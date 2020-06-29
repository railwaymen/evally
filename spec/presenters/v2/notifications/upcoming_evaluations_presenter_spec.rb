# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Notifications::UpcomingEvaluationsPresenter do
  describe 'fresh employees' do
    it 'expects to fetch proper employees' do
      admin = FactoryBot.create(:user, role: :admin)

      employee1 = FactoryBot.create(
        :employee,
        next_evaluation_on: nil,
        hired_on: 3.months.ago
      )

      FactoryBot.create(
        :employee,
        next_evaluation_on: nil,
        hired_on: 1.month.ago
      )

      FactoryBot.create(
        :employee,
        next_evaluation_on: 1.month.from_now,
        hired_on: 3.months.ago
      )

      presenter = described_class.new(admin)

      expect(presenter.fresh_employees.ids).to contain_exactly employee1.id
    end
  end

  describe 'regular employees' do
    it 'expects to fetch proper employees' do
      admin = FactoryBot.create(:user, role: :admin)

      travel_to Date.new(2020, 6, 1) do
        employee1 = FactoryBot.create(
          :employee,
          next_evaluation_on: 2.months.ago
        )

        employee2 = FactoryBot.create(
          :employee,
          next_evaluation_on: Date.new(2020, 6, 1)
        )

        FactoryBot.create(
          :employee,
          next_evaluation_on: 2.months.from_now
        )

        presenter = described_class.new(admin)

        expect(presenter.regular_employees.ids).to contain_exactly(
          employee1.id, employee2.id
        )
      end
    end
  end

  describe 'mail subject' do
    it 'expects to generate proper mail subject' do
      admin = FactoryBot.create(:user, role: :admin)
      presenter = described_class.new(admin)

      travel_to Date.new(2020, 6, 1) do
        expect(presenter.mail_subject).to eq 'Upcoming Evaluations Reminder - June 2020'
      end
    end
  end
end