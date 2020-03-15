# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body          { 'Lorem ipsum dolor sit amet ....' }
    created_by    { 'human' }

    recruit
    user
  end
end
