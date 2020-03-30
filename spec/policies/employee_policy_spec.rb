# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeePolicy, type: :policy do
  describe 'scope' do
    it 'returns correct scope' do
      admin = FactoryBot.create(:user, role: 'admin')
      evaluator = FactoryBot.create(:user, role: 'evaluator')

      employee1 = FactoryBot.create(:employee)
      employee2 = FactoryBot.create(:employee, evaluator: evaluator)

      aggregate_failures 'for admin' do
        scope = V2::EmployeePolicy::Scope.new(admin, Employee).resolve

        expect(scope.ids).to contain_exactly(employee1.id, employee2.id)
      end

      aggregate_failures 'for evaluator' do
        scope = V2::EmployeePolicy::Scope.new(evaluator, Employee).resolve

        expect(scope.ids).to contain_exactly(employee2.id)
      end
    end
  end
end
