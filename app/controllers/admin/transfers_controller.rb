# transfer
class Admin::TransfersController < Admin::BaseController
  def index
    @transfers_below = Transfer.below.order(created_at: :desc).decorate
    @transfers_above = Transfer.above.order(created_at: :desc).decorate
  end

  def new
    @transfer = Transfer.new
    support.build_associations
  end

  def create
    @transfer = Transfer.new(transfer_create_params)
    if @transfer.save
      flash.notice = t ".success"
      redirect_to root_path
    else
      support
      render :new
    end
  end

  def fee
    amount = params[:amount].to_f
    fee = Admin::Transfers::CalculateFeeService.new(amount, params[:currency]).call
    msg = I18n.t("errors.messages.greater_than", count: fee) if amount <= fee
    render json: {fee: fee, msg: msg}
  end

  private

  def transfer_create_params
    Admin::TransferParams.new(params).to_create_params
  end

  def support
    @support = Admin::TransferSupport.new @transfer
  end
end
