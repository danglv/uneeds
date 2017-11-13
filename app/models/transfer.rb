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
end
