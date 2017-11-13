# Currency
class M::Currency < ActiveHash::Base
  self.data = [{ id: 1, name: "JPY" }, { id: 2, name: "CNY" }]
end
