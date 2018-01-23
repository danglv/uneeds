# TransfersController
class TransfersController < ApplicationController
  def index
    @transfers_below = current_user.transfers.below.order(created_at: :desc).decorate
    @transfers_above = current_user.transfers.above.order(created_at: :desc).decorate
  end

  def new
    @kind = params[:kind]
    @transfer = Transfer.new(kind: @kind)
    support.build_associations
  end

  def create
    @transfer = Transfer.new(transfer_params)
    @kind = @transfer.kind
    @transfer.user = current_user
    set_transfer_attributes if @transfer.kind == Transfer.kinds.keys.first
    if @transfer.save
      flash.notice = t ".success"
      redirect_to root_path
    else
      @transfer.errors.messages
      support
      render :new
    end
  end

  def fee
    # TODO : Change calculate fee service depend on amount and exchange_id
    amount = params[:amount].to_f
    fee = TransferFeeService.new(amount).fee
    msg = I18n.t("errors.messages.greater_than", count: fee) if amount <= fee
    render json: { fee: fee, msg: msg }
  end

  private

  def transfer_params
    params.require(:transfer).permit Transfer::ATTRIBUTES
  end

  def load_transfer
    @transfer = Transfer.find params[:id]
  end

  def set_transfer_attributes
    @transfer.payment.fee = payment_fee
    @transfer.payment.guaranteed_rate = guaranteed_rate
    @transfer.payment.transfer_amount = (
      @transfer.payment.amount.to_f - payment_fee
    ) * guaranteed_rate
    @transfer.user = current_user
  end

  def payment_fee
    TransferFeeService.new(@transfer.payment.amount).fee
  end

  def guaranteed_rate
    UneedsExchange.find(exchange_id).guaranteed_rate
  end

  def exchange_id
    params[:transfer][:payment_attributes][:exchange_id]
  end

  def support
    @support = TransferSupport.new @transfer
  end
end
