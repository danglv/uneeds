class Admin::HighTransfersController < Admin::BaseController
  def new
    @high_transfer = HighTransfer.new(currency: :jpy)
    support
  end

  def create
    @high_transfer = HighTransfer.new(high_transfer_params)
    if @high_transfer.save
      flash.notice = t ".success"
      redirect_to root_path
    else
      support
      render :new
    end
  end

  private

  def high_transfer_params
    params.require(:high_transfer).permit HighTransfer::PERMITTED_ATTRIBUTES
  end

  def support
    @support = Admin::HighTransferSupport.new @high_transfer
  end
end
