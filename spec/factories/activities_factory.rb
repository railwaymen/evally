FactoryBot.define do
  factory :activity do
    user

    trait :create do
      action  { 'create' }
    end

    trait :update do
      action  { 'update' }
    end

    trait :destroy do
      action  { 'destroy' }
    end

    trait :complete do
      action  { 'complete' }
    end

    factory :employee_activity do
      activable { |a| a.association(:employee) }
    end
  end
end
