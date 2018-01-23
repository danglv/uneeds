class Admin::HighTransferSupport
  attr_reader :high_transfer

  def initialize(high_transfer)
    @high_transfer = high_transfer
  end

  def from_currency
    high_transfer.currency
  end

  def to_currency
    (HighTransfer.currencies.keys - [from_currency]).first
  end

  def from_jpy?
    high_transfer.jpy?
  end

  def jpy_data
    { currency: :jpy }
  end

  def cny_data
    { currency: :cny }
  end
end
