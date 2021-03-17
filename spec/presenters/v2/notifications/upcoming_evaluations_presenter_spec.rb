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

  describe 'scheduled employees' do
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
          next_evaluation_on: nil
        )

        FactoryBot.create(
          :employee,
          next_evaluation_on: 2.months.ago,
          state: 'archived'
        )

        presenter = described_class.new(admin)

        expect(presenter.scheduled_employees.ids).to contain_exactly(
          employee1.id, employee2.id
        )
      end
    end
  end

  describe 'unscheduled employees' do
    it 'expects to fetch proper employees' do
      admin = FactoryBot.create(:user, role: :admin)

      travel_to Date.new(2020, 6, 1) do
        employee1 = FactoryBot.create(
          :employee,
          last_evaluation_on: 2.months.ago,
          next_evaluation_on: nil
        )

        FactoryBot.create(
          :employee,
          next_evaluation_on: Date.new(2020, 6, 1)
        )

        presenter = described_class.new(admin)

        expect(presenter.unscheduled_employees.ids).to contain_exactly(
          employee1.id
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
