# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    action { 'create' }
    user

    factory :employee_activity do
      activable { |a| a.association(:employee) }
    end

    factory :evaluation_activity do
      activable { |a| a.association(:evaluation) }
    end
  end
end
