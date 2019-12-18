# frozen_string_literal: true

FactoryBot.define do
  factory :evaluation do
    employee
    state                     { 'draft' }
    sequence(:template_name)  { |n| "Template no.#{n}" }

    trait :completed do
      state           { 'completed' }
      completed_at    { 1.hour.ago }
    end

    factory :evaluation_with_sections do
      after(:create) do |ev|
        create(
          :section,
          :rating,
          sectionable: ev,
          skills: [
            { name: 'Photoshop', value: 1, needToImprove: false },
            { name: 'Illustrator', value: 2, needToImprove: false },
            { name: 'CorelDraw', value: 3, needToImprove: false },
            { name: 'Paint', value: 0, needToImprove: false }
          ]
        )

        create(
          :section,
          :bool,
          sectionable: ev,
          skills: [
            { name: 'Time', value: false, needToImprove: false },
            { name: 'Cooperation', value: true, needToImprove: false },
            { name: 'Relations', value: false, needToImprove: false }
          ]
        )

        create(
          :section,
          :text,
          sectionable: ev,
          skills: [
            { name: 'Competitions', value: 'Lorem ipsum', needToImprove: false },
            { name: 'Tutorials', value: '', needToImprove: false }
          ]
        )
      end
    end
  end
end
