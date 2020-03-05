# frozen_string_literal: true

FactoryBot.define do
  factory :recruit do
    evaluator { create(:user) }

    before(:create) do |recruit|
      document = create(:recruit_document)

      recruit.external_id = document.encrypted_email
    end
  end
end
