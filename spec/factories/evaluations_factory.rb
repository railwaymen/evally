FactoryBot.define do
  factory :evaluation do
    employee
    state     { 'draft' }

    trait :completed do
      state           { 'completed' }
      completed_at    { 1.hour.ago }
    end
  end
end
