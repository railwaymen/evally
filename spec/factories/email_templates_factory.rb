# frozen_string_literal: true

FactoryBot.define do
  factory :email_template do
    name        { 'Feedback Email Template' }
    subject     { 'Recruitment Process - Feedback' }
    body        { 'Lorem ipsum <strong>dolor</strong> sit amet...' }

    creator { create(:user) }
  end
end
