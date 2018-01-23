# Renders the home page.
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @bank_exchanges = BankExchange.order jp_name: :desc, currency_from_id: :asc
    @uneeds_exchanges = UneedsExchange.order :currency_from_id
    @high_jpy_transfers = Transfer.include_payment_user.above.by_currency(:jpy)
      .order(created_at: :desc).limit(Settings.max_high_transfers).decorate
    @high_cny_transfers = Transfer.include_payment_user.above.by_currency(:cny)
      .order(created_at: :desc).limit(Settings.max_high_transfers).decorate
  end
end
