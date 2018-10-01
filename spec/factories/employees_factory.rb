FactoryBot.define do
  factory :employee do |e|
    e.sequence(:first_name)     { Faker::Name.first_name }
    e.sequence(:last_name)      { Faker::Name.last_name }
    e.sequence(:position)       { Faker::Job.title }
    e.sequence(:hired_at)       { Faker::Date.between(1.month.ago, Time.now) }
    
    user
  end
end
