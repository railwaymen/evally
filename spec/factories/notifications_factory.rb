# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    read_at     { 1.minute.ago }
    action      { 'update' }

    notifiable  { create(:employee) }
    recipient   { create(:user) }
    actor       { create(:user) }
  end
end
