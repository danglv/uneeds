class Admin::TransferSupport
  attr_reader :transfer

  def initialize(transfer)
    @transfer = transfer
  end

  def build_associations
    transfer.build_sender(currency: :jpy)
    transfer.build_recipient(currency: :cny)
    transfer.build_payment
  end

  def from_currency
    transfer.sender_currency
  end

  def to_currency
    transfer.recipient_currency
  end

  def from_jpy?
    transfer.sender.jpy?
  end

  def from_jpy_data
    { currency: :jpy }
  end

  def from_cny_data
    { currency: :cny }
  end

  def real_amount
    (amount - fee) if amount && fee
  end

  private

  def payment
    transfer.payment
  end

  def amount
    payment&.amount
  end

  def fee
    payment&.fee
  end
end
