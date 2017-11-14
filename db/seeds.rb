# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Exchange.create(
  [
    { currency_from_id: 1, currency_to_id: 2, guaranteed_rate: 0.05831 },
    { currency_from_id: 2, currency_to_id: 1, guaranteed_rate: 17.14972 }
  ]
)
