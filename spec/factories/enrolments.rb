# frozen_string_literal: true

FactoryBot.define do
  factory :enrolment do
    status        { 'fresh' }
    phone         { '000-000-000' }
    group         { 'Ruby' }
    position      { 'Junior RoR Dev' }
    source        { 'website form' }
    received_at   { 1.minute.ago }
    social_links  { { github: 'http://github.com/example' } }

    candidate
  end
end
