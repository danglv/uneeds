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

class UneedsExchange < Exchange
end
