# Exchange
class M::Exchange < ActiveHash::Base
  self.data = [
    { id: 1, name: "中国銀行為替", guaranteed_rate_from_jpy: 0.05953,
      guaranteed_rate_from_cny: 16.85 },
    { id: 2, name: "銀聯為替", guaranteed_rate_from_jpy: 0.05952,
      guaranteed_rate_from_cny: 16.83 },
    { id: 3, name: "アリペイ", guaranteed_rate_from_jpy: 0.0595,
      guaranteed_rate_from_cny: 16.84 },
    { id: 4, name: "Yahoo Japan", guaranteed_rate_from_jpy:
      0.0591, guaranteed_rate_from_cny: 16.93 }
  ]
end
