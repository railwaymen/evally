# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { is_expected.to validate_presence_of(:action) }

  describe 'methods' do
    context '.body' do
      it 'return proper body for employee as notifiable' do
        employee = FactoryBot.create(:employee)
        user = FactoryBot.create(:user)

        notification = FactoryBot.create(
          :notification,
          actor: user,
          notifiable: employee,
          action: 'create'
        )

        expect(notification.body).to eq(
          I18n.t(
            'notifications.employee.create',
            notifiable_name: employee.fullname,
            actor_name: user.fullname
          )
        )
      end

      it 'return proper body for evaluation as notifiable' do
        evaluation = FactoryBot.create(:evaluation_draft_employee)
        user = FactoryBot.create(:user)

        notification = FactoryBot.create(
          :notification,
          actor: user,
          notifiable: evaluation,
          action: 'start_evaluation'
        )

        expect(notification.body).to eq(
          I18n.t(
            'notifications.evaluation.start_evaluation',
            notifiable_name: evaluation.employee.fullname,
            actor_name: user.fullname
          )
        )
      end
    end
  end
end
