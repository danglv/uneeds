# Renders the home page.
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @bank_exchanges = BankExchange.order jp_name: :desc, currency_from_id: :asc
    @uneeds_exchanges = UneedsExchange.order :currency_from_id
    @transfers_above = Transfer.above.order(created_at: :desc).decorate
  end
end
