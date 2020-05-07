# frozen_string_literal: true

FactoryBot.define do
  factory :recruit do
    public_recruit_id   { Digest::SHA256.hexdigest(Faker::Internet.email) }
    evaluator           { create(:user, role: :evaluator) }
  end
end
