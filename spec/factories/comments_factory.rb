# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body                  { 'Lorem ipsum dolor sit amet ....' }
    created_by            { 'human' }
    change_id             { nil }
    recruit_document_id   { 1 }

    recruit
    user
  end
end
