# exchange
class Admin::ExchangesController < Admin::BaseController
  before_action :set_exchange, only: %i[edit update]
  def index
    @exchanges = Exchange.all
  end

  def edit
  end

  def update
    if @exchange.update(exchange_params)
      flash.now[:notice] = "success"
      redirect_to admin_exchanges_path
    else
      render :edit
    end
  end

  private

  def set_exchange
    @exchange = Exchange.find params[:id]
  end

  def exchange_params
    params.require(:exchange).permit(:guaranteed_rate)
  end
end
