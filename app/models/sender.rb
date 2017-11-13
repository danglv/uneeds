# == Schema Information
#
# Table name: senders
#
#  address             :string
#  birthday            :datetime
#  city                :string
#  country             :string
#  created_at          :datetime         not null
#  first_name          :string
#  first_name_katakana :string
#  id                  :integer          not null, primary key
#  last_name           :string
#  last_name_katakana  :string
#  occupation          :string
#  phone               :string
#  post_code           :string
#  updated_at          :datetime         not null
#  user_id             :integer
#
# Indexes
#
#  index_senders_on_user_id  (user_id)
#

# Sender
class Sender < ApplicationRecord
  belongs_to :user
  has_many :transfers, dependent: :nullify
end
