# == Schema Information
#
# Table name: senders
#
#  address             :string
#  birthday            :datetime
#  city                :string
#  country             :integer
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
  has_one :transfer, dependent: :nullify
  validates :address, :birthday, :city, :country, :occupation, :phone,
            :post_code, :first_name, :last_name, presence: true
  validates :first_name_katakana, :last_name_katakana,
            presence: true, if: :from_japan?

  enum country: %i[china japan]

  PERMITTED_ATTRIBUTES = %i[
    first_name last_name first_name_katakana last_name_katakana country city
    address phone post_code birthday occupation
  ].freeze

  private

  def from_japan?
    transfer.payment.uneeds_exchange.currency_from_id == 1
  end

  def from_china?
    transfer.payment.uneeds_exchange.currency_from_id == 2
  end
end
