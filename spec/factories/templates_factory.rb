# frozen_string_literal: true

FactoryBot.define do
  factory :template do
    sequence(:name) { |n| "Template no.#{n}" }
    destination     { 'employees' }

    creator { create(:user) }
  end
end
