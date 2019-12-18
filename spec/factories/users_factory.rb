# frozen_string_literal: true

FactoryBot.define do
  factory :user do |u|
    u.sequence(:email)     { |t| "user#{t}@example.com" }
    password               { '1234qwer' }
    first_name             { Faker::Name.first_name }
    last_name              { Faker::Name.last_name }

    factory :user_with_employees do
      after(:create) do |user|
        5.times { create(:employee, user: user) }
      end
    end
  end
end
