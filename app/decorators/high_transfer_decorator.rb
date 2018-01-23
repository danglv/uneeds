class HighTransferDecorator < ApplicationDecorator
  include CurrencyDecoratorModule
  delegate_all
  delegate :email, to: :user, prefix: true

  def buy_currency
    I18n.t "dictionary.buy_#{currency}"
  end

  def high_amount
    I18n.t "transfers.high_amount", amount: amount.to_f / 10_000,
      currency: decorated_currency
  end
end
