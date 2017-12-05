# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

logger = Logger.new(STDOUT)
logger.info "Creating seeds data..."
[:exchange].each do |klass_name|
  klass = klass_name.to_s.classify.safe_constantize
  logger.info "-- Clear data for #{klass.name}"
  klass.delete_all
  logger.info "-- Creating seeds data for #{klass.name}"
  ActiveRecord::Base.transaction do
    CSV.open(
      Rails.root.join("db", "csv", "#{klass_name.to_s.pluralize}.csv"),
      headers: true, header_converters: :downcase
    ).each do |row|
      attrs = row.to_hash
      klass.create! attrs
    end
  end
end

logger.info "-- Creating 10 admins..."
10.times do |i|
  u = User.create email: "admin#{i + 1}@uneeds.tomosia.com",
    password: "Aa@123456"
  u.add_role :admin
end
