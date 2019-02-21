FactoryBot.define do
  factory :template do |et|
    et.sequence(:name) { Faker::Lorem.word }
    state              { 'draft' }

    user

    factory :template_with_sections do
      transient do
        sections_count { 3 }
      end

      after(:create) do |template, faktory|
        create_list(:section, faktory.sections_count, sectionable: template)
      end
    end

    factory :draft_template do
      after(:create) do |temp|
        create(
          :section,
          :rating,
          sectionable: temp,
          skills: [
            { name: 'Illustrator', value: 0, needToImprove: false },
            { name: 'Visual Code', value: 0, needToImprove: false }
          ]
        )
      end
    end
  end
end
