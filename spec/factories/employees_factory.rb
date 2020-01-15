# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    first_name    { 'Rob' }
    last_name     { 'Reddington' }
    position      { 'Programmer' }
    hired_at      { 1.month.ago }
    state         { 'hired' }

    user
  end
end
