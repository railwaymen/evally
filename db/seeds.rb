# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# # ================= User =====================

current_user = User.find_or_create_by(email: 'john.doe@example.com') do |user|
  user.password = '1234qwer'
  user.first_name = 'John'
  user.last_name = 'Doe'
end

puts 'john.doe@example.com'

# # ============== Employees ===================

5.times do
  Employee.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    position: Faker::Job.title,
    hired_at: Faker::Date.between(1.month.ago, Time.now),
    user: current_user
  )
end

# # ============= Template ===================

5.times do
  template = Template.create(
    name: Faker::Lorem.words(2).join(' ').capitalize,
    state: 'draft',
    user: current_user
  )

  3.times do |n|
    skills = [
      { name: Faker::Lorem.words(2).join(' ').capitalize, value: nil },
      { name: Faker::Lorem.words(2).join(' ').capitalize, value: nil },
      { name: Faker::Lorem.words(2).join(' ').capitalize, value: nil }
    ]

    Section.create(
      name: Faker::Lorem.word.capitalize,
      group: ['bool', 'rating', 'text'].sample,
      width: 'half',
      position: n,
      skills: skills,
      sectionable: template
    )
  end
end
