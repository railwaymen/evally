# frozen_string_literal: true

FactoryBot.define do
  factory :template do
    sequence(:name) { Faker::Lorem.word }

    user
  end
end
