# frozen_string_literal: true

FactoryBot.define do
  factory :recruit_document do
    first_name        { 'John' }
    last_name         { 'Doe' }
    sequence(:email)  { |n| "recruit#{n}@example.com" }
    phone             { '000-000-000' }
    position          { 'Junior RoR Developer' }
    group             { 'Ruby' }
    received_at       { 1.minute.ago }
    source            { 'website' }
    accept_current_process 1
    accept_future_processes 0

    after(:create) do |document|
      create(:recruit, human_resources_id: document.encrypted_email)
    end
  end
end
