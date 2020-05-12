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
  u.status = 'active'
end

if Rails.env.development?
  require 'faker'

  positions = [
    ['Ruby on Rails Developer', 'Ruby'],
    ['JavaScript Developer', 'JavaScript'],
    ['Python Developer', 'Python'],
    ['Android Developer', 'Android'],
    ['iOS Developer', 'iOS'],
    ['QA Specialist', 'QA'],
    ['Graphic Designer', 'Design'],
    ['Fronted Developer', 'Fronted'],
    ['Project Manager', 'Managers']
  ]

  levels = ['Junior ', '', 'Senior ', 'Ninja ']

  30.times do
    position = positions.sample

    Employee.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      position: "#{levels.sample}#{position.first}",
      group: position.last,
      hired_on: Faker::Date.between(1.year.ago, Time.now)
    )
  end
end
