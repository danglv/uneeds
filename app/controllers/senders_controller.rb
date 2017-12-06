# SendersController
class SendersController < ApplicationController
  def index
    @senders = current_user.senders.decorate
  end

  def edit
    sender
    support
  end

  def update
    if sender.update_attributes(sender_params)
      flash[:notice] = t ".success"
      redirect_to senders_path
    else
      support
      render :edit
    end
  end

  private

  def sender
    @sender = Sender.find params[:id]
  end

  def support
    @support = SenderSupport.new
  end

  def sender_params
    params.require(:sender).permit Sender::PERMITTED_ATTRIBUTES
  end
end
