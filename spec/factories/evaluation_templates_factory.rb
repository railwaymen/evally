FactoryBot.define do
  factory :evaluation_template do |et|
    et.sequence(:name) { Faker::Lorem.word }
    state              { 'draft' }
    evaluations_count  { 0 }
    
    user

    trait :enabled do
      state { 'enabled' }
    end

    trait :disabled do
      state { 'disabled' }
    end

    trait :removed do
      state { 'removed' }
    end
  end
end
