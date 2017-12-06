# exchange
class Admin::ExchangesController < Admin::BaseController
  before_action :set_exchange, only: %i[edit update]
  def index
    @bank_exchanges = BankExchange.order jp_name: :desc, currency_from_id: :asc
    @uneeds_exchanges = UneedsExchange.order :currency_from_id
  end

  def edit
  end

  def update
    if @exchange.update(exchange_params)
      flash[:notice] = t ".success"
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
    params.require(:exchange).permit(:jp_name, :cn_name, :guaranteed_rate)
  end
end
