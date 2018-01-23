module CurrencyDecoratorModule
  def decorated_currency
    I18n.t "dictionary.currencies.#{object.currency}" if object.currency
  end
end
