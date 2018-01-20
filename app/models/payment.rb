# == Schema Information
#
# Table name: payments
#
#  amount          :float
#  created_at      :datetime         not null
#  exchange_id     :integer
#  fee             :float
#  guaranteed_rate :float
#  id              :integer          not null, primary key
#  transfer_amount :float
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_payments_on_exchange_id  (exchange_id)
#

# Payment
class Payment < ApplicationRecord
  belongs_to :uneeds_exchange, foreign_key: "exchange_id", optional: true
  has_one :transfer, dependent: :nullify

  validates :amount, presence: true
  validates :guaranteed_rate, presence: true,
    if: proc { |p| p.exchange_id.nil? }
  validates_numericality_of :amount, greater_than: proc { |p| p.fee.to_f }
  before_create :set_guaranteed_rate, if: proc { |p| p.exchange_id.present? }

  delegate :sender_currency, to: :transfer, allow_nil: true

  private

  def set_guaranteed_rate
    self.guaranteed_rate = uneeds_exchange.guaranteed_rate
  end
end
