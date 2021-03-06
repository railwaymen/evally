# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EvaluationPolicy, type: :policy do
  describe 'scope' do
    it 'returns correct scope for employees' do
      admin = FactoryBot.create(:user, role: 'admin')
      evaluator = FactoryBot.create(:user, role: 'evaluator')

      employee1 = FactoryBot.create(:employee)
      employee2 = FactoryBot.create(:employee, evaluator: evaluator)

      evaluation1 = FactoryBot.create(:evaluation_draft_employee, evaluable: employee1)
      evaluation2 = FactoryBot.create(:evaluation_draft_employee, evaluable: employee2)

      aggregate_failures 'for admin' do
        scope = V2::EvaluationPolicy::EmployableScope.new(admin, Evaluation).resolve

        expect(scope.ids).to contain_exactly(evaluation1.id, evaluation2.id)
      end

      aggregate_failures 'for evaluator' do
        scope = V2::EvaluationPolicy::EmployableScope.new(evaluator, Evaluation).resolve

        expect(scope.ids).to contain_exactly(evaluation2.id)
      end
    end
  end
end
