FactoryBot.define do
  factory :section do |s|
    s.sequence(:name)     { |n| "Section no.#{n}" }
    group                 { 'text' }
    width                 { 'full' }
    s.sequence(:position) { |n| n }
    skills                { [{ name: 'Description', value: 'Lorem ipsum dolor sit amet ...', needToImprove: false }] }

    trait :rating do
      group     { 'rating' }
      width     { 'half' }
      skills    { [{ name: 'Lorem', value: 3, needToImprove: false }, { name: 'Ipsum', value: 4, needToImprove: false }] }
    end

    trait :bool do
      group     { 'bool' }
      width     { 'half' }
      skills    { [{ name: 'Dolor', value: true, needToImprove: false }, { name: 'Amet', value: false, needToImprove: false }] }
    end

    trait :text do
      group     { 'text' }
      width     { 'full' }
      skills    { [{ name: 'Dolor', value: '', needToImprove: false }, { name: 'Amet', value: '', needToImprove: false }] }
    end

    trait :for_template do
      sectionable { |a| a.association(:template) }
    end
  end
end
