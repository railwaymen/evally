# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  describe 'upcoming evaluations' do
    it 'expect to have proper to attribute' do
      admin = FactoryBot.create(:user, role: :admin)
      FactoryBot.create(:employee, hired_on: 3.months.ago)

      mail = described_class.with(user: admin).upcoming_evaluations

      expect(mail.to).to contain_exactly admin.email
    end
  end
end
