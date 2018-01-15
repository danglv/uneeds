# == Schema Information
#
# Table name: senders
#
#  created_at    :datetime         not null
#  currency      :integer
#  id            :integer          not null, primary key
#  name          :string
#  name_katakana :string
#  phone         :string
#  updated_at    :datetime         not null
#  user_id       :integer
#  wechat_id     :string
#
# Indexes
#
#  index_senders_on_user_id  (user_id)
#

# Sender
class Sender < ApplicationRecord
  belongs_to :user
  has_one :transfer, dependent: :nullify
  validates :name, presence: true
  validates :name_katakana, presence: true, if: :from_japan?
  validate :must_have_phone_or_wechat

  enum country: %i[china japan]
  enum currency: %i[jpy cny]

  PERMITTED_ATTRIBUTES = %i[name name_katakana phone].freeze

  private

  def from_japan?
    return false unless below_kind?
    transfer.payment.uneeds_exchange.currency_from_id == 1
  end

  def from_china?
    transfer.payment.uneeds_exchange.currency_from_id == 2
  end

  def below_kind?
    transfer.kind == Transfer.kinds.keys.first
  end

  def must_have_phone_or_wechat
    if phone.blank? && wechat_id.blank?
      errors.add(:phone, I18n.t(".errors.messages.sender.phone_or_wechat_require"))
      errors.add(:wechat_id, I18n.t(".errors.messages.sender.phone_or_wechat_require"))
    end
  end
end
