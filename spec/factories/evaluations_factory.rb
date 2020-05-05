# frozen_string_literal: true

FactoryBot.define do
  factory :evaluation do
    sequence(:template_name) { |n| "Template no.#{n}" }
    position                 { 'Just Employee' }

    trait :employee do
      evaluable             { |a| a.association(:employee) }
      recruit_document_id   { nil }
    end

    trait :recruit do
      evaluable             { |a| a.association(:recruit) }
      recruit_document_id   { 1 }
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

    factory :evaluation_draft_recruit, traits: %i[recruit draft]
    factory :evaluation_completed_recruit, traits: %i[recruit completed]
  end
end
