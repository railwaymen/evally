# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::ActivityPolicy, type: :policy do
  describe 'scope' do
    it 'returns correct scope' do
      admin = FactoryBot.create(:user, role: 'admin')
      evaluator = FactoryBot.create(:user, role: 'evaluator')

      activity1 = FactoryBot.create(:employee_activity)
      activity2 = FactoryBot.create(:employee_activity, user: evaluator)

      aggregate_failures 'for admin' do
        scope = V2::ActivityPolicy::Scope.new(admin, Activity).resolve

        expect(scope.ids).to contain_exactly(activity1.id, activity2.id)
      end

      aggregate_failures 'for evaluator' do
        scope = V2::ActivityPolicy::Scope.new(evaluator, Activity).resolve

        expect(scope.ids).to contain_exactly(activity2.id)
      end
    end
  end
end
