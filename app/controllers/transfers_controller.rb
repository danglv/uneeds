# TransfersController
class TransfersController < ApplicationController
  before_action :load_transfer, only: [:edit]
  def new
    @transfer = Transfer.new
    @transfer.build_sender
    @transfer.build_recipient
    @transfer.build_payment
    @exchange_jpy = Exchange.find 1
    @exchange_cny = Exchange.find 2
  end

  def edit
  end

  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.user = current_user
    if @transfer.save
      flash.now[:notice] = "success"
      redirect_to root_path
    else
      flash.now[:error] = "error"
      @exchange_jpy = Exchange.find 1
      @exchange_cny = Exchange.find 2
      render :edit
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit Transfer::ATTRIBUTES
  end

  def load_transfer
    @transfer = Transfer.find params[:id]
  end
end
