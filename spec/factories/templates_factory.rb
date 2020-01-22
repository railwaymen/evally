# frozen_string_literal: true

FactoryBot.define do
  factory :template do |et|
    et.sequence(:name) { Faker::Lorem.word }
    state              { 'draft' }

    user
  end
end
