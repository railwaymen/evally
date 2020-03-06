# frozen_string_literal: true

FactoryBot.define do
  factory :template do
    sequence(:name) { |n| "Template no.#{n}" }
    destination     { 'evaluation' }

    creator { create(:user) }
  end
end
