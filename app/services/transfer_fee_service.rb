# Transfer Fee
class TransferFeeService
  def initialize(amount)
    @amount = amount
  end

  def fee
    return 1000 if @amount > 10_000
    500
  end
end
