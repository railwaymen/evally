FactoryBot.define do
  factory :evaluation do
    employee
    state             { 'draft' }
    template_name     { |n| "Template no.#{n}" }

    trait :completed do
      state           { 'completed' }
      completed_at    { 1.hour.ago }
    end

    factory :evaluation_with_sections do
      transient do
        sections_count { 3 }
      end

      after(:create) do |template, faktory|
        create_list(:section, faktory.sections_count, sectionable: template)
      end
    end
  end
end
