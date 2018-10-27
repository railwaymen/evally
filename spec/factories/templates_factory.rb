FactoryBot.define do
  factory :template do |et|
    et.sequence(:name) { Faker::Lorem.word }
    state              { 'draft' }
    
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

    factory :template_with_sections do
      transient do
        sections_count { 3 }
      end

      after(:create) do |template, faktory|
        create_list(:section, faktory.sections_count, sectionable: template)
      end
    end
  end
end
