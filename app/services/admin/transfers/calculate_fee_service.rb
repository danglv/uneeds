class Admin::Transfers::CalculateFeeService
  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = amount.to_f
    @currency = currency.to_sym
  end

  def call
    case currency
    when :jpy
      calculate_jpy_fee
    when :cny
      calculate_cny_fee
    end
  end

  private

  def calculate_jpy_fee
    amount > 10_000 ? 1000 : 500
  end

  def calculate_cny_fee
    amount > 500 ? 50 : 25
  end
end
