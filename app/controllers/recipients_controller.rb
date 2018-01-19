class RecipientsController < ApplicationController
  def index
    @recipients = current_user.recipients.decorate
  end

  def edit
    recipient
  end

  def update
    if recipient.update_attributes recipient_params
      flash.notice = t ".success"
      redirect_to recipients_path
    else
      render :edit
    end
  end

  def destroy
    if recipient.destroy
      flash[:notice] = t ".success"
    else
      flash[:alert] = t ".failure"
    end
    redirect_to recipients_path
  end

  private

  def recipient
    @recipient = Recipient.find params[:id]
  end

  def recipient_params
    params.require(:recipient).permit Recipient::PERMITTED_ATTRIBUTES
  end
end
