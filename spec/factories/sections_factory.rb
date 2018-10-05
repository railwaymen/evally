FactoryBot.define do
  factory :section do |s|
    s.sequence(:name)     { Faker::Lorem.word }
    group                 { 'text' }
    width                 { 'full' }
    s.sequence(:position) { |n| n }
    skills                { [{ description: 'Lorem ipsum dolor sit amet...' }] }

    trait :rating do
      group     { 'rating' }
      width     { 'half' }
      skills    { [{ name: 'Lorem', value: 3 }, { name: 'Ipsum', value: 4 }] }
    end

    trait :bool do
      group     { 'bool' }
      width     { 'half' }
      skills    { [{ name: 'Dolor', value: true }, { name: 'Amet', value: false }] }
    end

    trait :for_template do
      sectionable { |a| a.association(:template) }
    end
  end
end
