# == Schema Information
#
# Table name: recipients
#
#  account_number :string
#  account_type   :integer
#  bank_name      :string
#  branch_name    :string
#  created_at     :datetime         not null
#  currency       :integer
#  email          :string
#  full_name      :string
#  id             :integer          not null, primary key
#  kind           :string
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_recipients_on_user_id  (user_id)
#

# Recipient
class Recipient < ApplicationRecord
  belongs_to :user
  has_many :transfers, dependent: :nullify

  validates :account_number, :bank_name, :branch_name, :full_name,
            :currency, presence: true

  validates :account_type, presence: true, if: :cny_to_jpy?

  enum account_type: %i[futsuu chochiku touza]
  enum currency: %i[jpy cny]

  PERMITTED_ATTRIBUTES = %i[
    full_name email account_number account_type bank_name branch_name
  ].freeze

  private

  def from_japan?
    transfer.payment.uneeds_exchange.currency_from_id == 1
  end

  def from_china?
    transfer.payment.uneeds_exchange.currency_from_id == 2
  end

  def cny_to_jpy?
    # return false unless below_kind?
    jpy?
  end
end
