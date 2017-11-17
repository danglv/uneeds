# == Schema Information
#
# Table name: payments
#
#  amount          :float
#  created_at      :datetime         not null
#  exchange_id     :integer
#  guaranteed_rate :float
#  id              :integer          not null, primary key
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_payments_on_exchange_id  (exchange_id)
#

# Payment
class Payment < ApplicationRecord
  belongs_to :exchange
  has_one :transfers, dependent: :nullify

  validates :amount, presence: true
  before_create :set_guaranteed_rate

  private

  def set_guaranteed_rate
    self.guaranteed_rate = exchange.guaranteed_rate
  end
end
