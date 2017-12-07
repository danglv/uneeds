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
  belongs_to :uneeds_exchange, foreign_key: "exchange_id"
  has_one :transfer, dependent: :nullify

  validates :amount, presence: true
  before_create :set_guaranteed_rate

  private

  def set_guaranteed_rate
    self.guaranteed_rate = exchange.guaranteed_rate
  end
end
