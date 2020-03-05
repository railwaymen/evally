# frozen_string_literal: true

FactoryBot.define do
  factory :candidate do
    sequence(:email)  { |n| "user#{n}@example.com" }
    first_name        { 'Bruce' }
    last_name         { 'Willis' }

    evaluator { create(:user) }
  end
end
