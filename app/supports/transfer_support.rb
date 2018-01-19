class TransferSupport
  attr_reader :transfer

  def initialize(transfer)
    @transfer = transfer
  end

  def build_associations
    transfer.build_sender
    transfer.build_recipient
    transfer.build_payment
  end

  def exchange_id
    transfer.payment_exchange_id || from_jpy_exchange.id
  end

  def guaranteed_rate
    transfer.payment_guaranteed_rate || from_jpy_exchange.guaranteed_rate
  end

  def from_currency
    transfer.sender_currency || :jpy
  end

  def to_currency
    transfer.recipient_currency || :cny
  end

  def from_cny?
    exchange_id == from_cny_exchange.id
  end

  def from_jpy?
    exchange_id == from_jpy_exchange.id
  end

  def from_jpy_data
    {
      exchange_id: from_jpy_exchange.id,
      guaranteed_rate: from_jpy_exchange.guaranteed_rate,
      currency: :jpy
    }
  end

  def from_cny_data
    {
      exchange_id: from_cny_exchange.id,
      guaranteed_rate: from_cny_exchange.guaranteed_rate,
      currency: :cny
    }
  end

  private

  def exchanges
    @exchanges ||= UneedsExchange.order :currency_from_id
  end

  def from_jpy_exchange
    exchanges.detect(&:from_jpy?)
  end

  def from_cny_exchange
    exchanges.detect(&:from_cny?)
  end
end
