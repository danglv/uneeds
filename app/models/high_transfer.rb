# == Schema Information
#
# Table name: high_transfers
#
#  amount          :float
#  created_at      :datetime         not null
#  currency        :integer
#  guaranteed_rate :float
#  id              :integer          not null, primary key
#  updated_at      :datetime         not null
#  user_id         :integer
#
# Indexes
#
#  index_high_transfers_on_user_id  (user_id)
#
class HighTransfer < ApplicationRecord
  PERMITTED_ATTRIBUTES = %i[user_id amount guaranteed_rate currency].freeze

  belongs_to :user

  enum currency: %i[jpy cny]

  validates :user_id, :amount, :guaranteed_rate, :currency, presence: true

  scope :include_user, -> { includes [:user] }
end
