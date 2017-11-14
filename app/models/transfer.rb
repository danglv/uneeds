# == Schema Information
#
# Table name: transfers
#
#  created_at     :datetime         not null
#  id             :integer          not null, primary key
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
  belongs_to :recipient
  belongs_to :payment

  accepts_nested_attributes_for :sender, :recipient, :payment
  ATTRIBUTES = [
    payment_attributes: %i[exchange_id amount user_id],
    sender_attributes: %i[first_name last_name birthday country city phone
                          post_code occupation user_id],
    recipient_attributes: %i[full_name email account_number account_type
                             bank_name branch_name currency ibank user_id]
  ].freeze

  before_create :set_data

  private

  def set_data
    self.sender_data = sender.as_json(except: %i[id created_at updated_at])
    self.recipient_data = recipient.as_json(except: %i[id created_at
                                                       updated_at])
  end
end
