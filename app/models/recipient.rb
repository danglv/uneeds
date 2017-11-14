# == Schema Information
#
# Table name: recipients
#
#  account_number :string
#  account_type   :string
#  bank_name      :string
#  branch_name    :string
#  created_at     :datetime         not null
#  currency       :string
#  email          :string
#  full_name      :string
#  ibank          :string
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

  validates :account_number, :account_type, :bank_name, :branch_name, :currency,
            :email, :full_name, :ibank, :kind, presence: true
end
