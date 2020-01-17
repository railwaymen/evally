# frozen_string_literal: true

FactoryBot.define do
  factory :section do
    sequence(:name)     { |n| "Section no.#{n}" }
    group               { 'text' }
    width               { 'full' }
    sequence(:position) { |n| n }

    skills do
      [
        {
          name: 'Description',
          value: 'Lorem ipsum dolor sit amet ...',
          needToImprove: false
        }
      ]
    end

    trait :rating do
      group     { 'rating' }
      width     { 'half' }

      skills do
        [
          {
            name: 'Lorem',
            value: 3,
            needToImprove: false
          },
          {
            name: 'Ipsum',
            value: 4,
            needToImprove: false
          }
        ]
      end
    end

    trait :bool do
      group     { 'bool' }
      width     { 'half' }

      skills do
        [
          {
            name: 'Dolor',
            value: true,
            needToImprove: false
          },
          {
            name: 'Amet',
            value: false,
            needToImprove: false
          }
        ]
      end
    end

    trait :text do
      group     { 'text' }
      width     { 'full' }

      skills do
        [
          {
            name: 'Dolor',
            value: '',
            needToImprove: false
          },
          {
            name: 'Amet',
            value: '',
            needToImprove: false
          }
        ]
      end
    end

    trait :for_template do
      sectionable { |a| a.association(:template) }
    end
  end
end
