# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Emails::BasicForm do
  let(:admin) { FactoryBot.create(:user, role: 'admin') }

  describe 'email validation' do
    it 'expects [from] to be valid' do
      recruit = FactoryBot.create(:recruit)

      values = [
        'john.doe@example.com',
        'john.doe+test@example.com',
        'john.doe@localhost',
        'John Doe <john.doe@example.com>',
        'John <john.doe@example.com>'
      ]

      values.map do |email|
        form = described_class.new(recruit, user: admin, params: { from: email })
        form.valid?

        expect(form.errors.messages[:from]).to be_empty
      end
    end

    it 'expects [from] to be invalid' do
      recruit = FactoryBot.create(:recruit)

      values = [
        'john.doe$example.com',
        'john.doe@',
        '@example.com',
        'john.doe',
        'John Doe <john.doe@example.com',
        'John john.doe@example.com>'
      ]

      values.map do |email|
        form = described_class.new(recruit, user: admin, params: { from: email })
        form.valid?

        expect(form.errors.messages[:from]).to contain_exactly 'is not a valid email'
      end
    end
  end
end
