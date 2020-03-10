# frozen_string_literal: true

FactoryBot.define do
  factory :evaluation do
    sequence(:template_name) { |n| "Template no.#{n}" }

    trait :employee do
      evaluable { |a| a.association(:employee) }
    end

    trait :draft do
      state           { 'draft' }
      completed_at    { nil }
    end

    trait :completed do
      state           { 'completed' }
      completed_at    { 1.hour.ago }
    end

    factory :evaluation_draft_employee, traits: %i[employee draft]
    factory :evaluation_completed_employee, traits: %i[employee completed]
  end
end
