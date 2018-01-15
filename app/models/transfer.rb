# == Schema Information
#
# Table name: transfers
#
#  created_at     :datetime         not null
#  id             :integer          not null, primary key
#  kind           :integer          default("below")
#  payment_id     :integer
#  recipient_data :json
#  recipient_id   :integer
#  sender_data    :json
#  sender_id      :integer
#  status         :string
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_transfers_on_payment_id    (payment_id)
#  index_transfers_on_recipient_id  (recipient_id)
#  index_transfers_on_sender_id     (sender_id)
#  index_transfers_on_user_id       (user_id)
#

# Transfer
class Transfer < ApplicationRecord
  belongs_to :user
  belongs_to :sender
  belongs_to :recipient, optional: true
  belongs_to :payment, optional: true
  enum kind: %i[below above]

  delegate :exchange_id, :guaranteed_rate, :amount, to: :payment, prefix: true,
    allow_nil: true
  delegate :currency, to: :sender, prefix: true, allow_nil: true
  delegate :currency, :full_name, to: :recipient, prefix: true, allow_nil: true

  accepts_nested_attributes_for :sender, :recipient, :payment
  ATTRIBUTES = [
    :kind,
    payment_attributes: %i[exchange_id amount user_id],
    sender_attributes: %i[name phone name_katakana currency user_id],
    recipient_attributes: %i[full_name email account_number account_type kind
                             bank_name branch_name currency ibank user_id]
  ].freeze

  scope :below, -> {where "kind = ?", 0}
  scope :above, -> {where "kind = ?", 1}

  before_create :set_data

  private

  def set_data
    self.sender_data = sender.as_json(except: %i[id created_at updated_at])
    self.recipient_data = recipient.as_json(except: %i[id created_at
                                                       updated_at])
  end
end
