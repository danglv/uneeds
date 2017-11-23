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
    set_transfer_attributes
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

  def fee
    fee = TransferFeeService.new(params[:amount].to_f).fee
    render json: { fee: fee }
  end

  private

  def transfer_params
    params.require(:transfer).permit Transfer::ATTRIBUTES
  end

  def load_transfer
    @transfer = Transfer.find params[:id]
  end

  def set_transfer_attributes
    fee = TransferFeeService.new(@transfer.payment.amount).fee
    @transfer.payment.fee = fee
    @transfer.payment.transfer_amount = @transfer.payment.amount - fee
    @transfer.user = current_user
  end
end
