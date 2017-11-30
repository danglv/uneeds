# Renders the home page.
class HomeController < ApplicationController
  def index
    @m_exchanges = M::Exchange.data
    @exchange_jpy = Exchange.find 1
    @exchange_cny = Exchange.find 2
  end
end
