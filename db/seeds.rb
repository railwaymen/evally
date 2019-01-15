# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# # ================= User =====================

User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.password = 'password'
  u.first_name = 'John'
  u.last_name = 'Doe'
end


if Rails.env.cypress?
  require 'faker'

  current_user = User.last

  ['Jan Kowalski', 'John Smith', 'Paul Walker'].each do |employee|
    Employee.create!(
      first_name: employee.split.first,
      last_name: employee.split.last,
      position: Faker::Job.title,
      hired_at: Faker::Date.between(1.year.ago, Time.now),
      user: current_user
    )
  end


end