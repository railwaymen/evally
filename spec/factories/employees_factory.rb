# frozen_string_literal: true

FactoryBot.define do
  factory :employee do |e|
    e.sequence(:first_name)         { Faker::Name.first_name }
    e.sequence(:last_name)          { Faker::Name.last_name }
    e.sequence(:position)           { Faker::Job.title }
    e.sequence(:hired_at)           { Faker::Date.between(1.month.ago, Time.not.utc) }
    e.sequence(:next_evaluation_at) { 1.month.from_now }
    e.sequence(:state)              { 'hired' }
    e.sequence(:released_at)        { nil }

    user
  end
end
