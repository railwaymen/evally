# frozen_string_literal: true

FactoryBot.define do
  factory :evaluation do
    sequence(:template_name) { |n| "Template no.#{n}" }
    employee

    trait :draft do
      state           { 'draft' }
      completed_at    { nil }
    end

    trait :completed do
      state           { 'completed' }
      completed_at    { 1.hour.ago }
    end
  end
end
