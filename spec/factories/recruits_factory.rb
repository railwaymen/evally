# frozen_string_literal: true

FactoryBot.define do
  factory :recruit do
    evaluator { create(:user) }
  end
end
