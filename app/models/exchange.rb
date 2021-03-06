# == Schema Information
#
# Table name: exchanges
#
#  cn_name          :string
#  code             :string
#  created_at       :datetime         not null
#  currency_from_id :integer
#  currency_to_id   :integer
#  guaranteed_rate  :float
#  id               :integer          not null, primary key
#  jp_name          :string
#  type             :string
#  updated_at       :datetime         not null
#

# Exchange
class Exchange < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :currency_from, class_name: "M::Currency",
    foreign_key: "currency_from_id"
  belongs_to_active_hash :currency_to, class_name: "M::Currency",
    foreign_key: "currency_to_id"

  def from_jpy?
    currency_from_id == 1
  end

  def from_cny?
    currency_from_id == 2
  end
end
