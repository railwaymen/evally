# frozen_string_literal: true

FactoryBot.define do
  factory :activity do
    action { 'create' }
    user

    factory :evaluation_activity do
      activable { |a| a.association(:evaluation) }
    end
  end
end
