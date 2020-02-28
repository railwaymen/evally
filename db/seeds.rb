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
  u.role = 'admin'
end

if Rails.env.development?
  require 'faker'

  current_user = User.last

  30.times do
    Employee.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      position: Faker::Job.title,
      hired_on: Faker::Date.between(1.year.ago, Time.now),
      evaluator_id: current_user.id
    )
  end
end
