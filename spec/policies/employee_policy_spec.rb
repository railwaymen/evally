# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeePolicy, type: :policy do
  let(:admin) { FactoryBot.create(:user, role: 'admin') }
  let(:recruiter) { FactoryBot.create(:user, role: 'recruiter') }
  let(:evaluator) { FactoryBot.create(:user, role: 'evaluator') }

  describe 'scope' do
    it 'returns correct scope' do
      employee1 = FactoryBot.create(:employee)
      employee2 = FactoryBot.create(:employee, evaluator: evaluator)

      aggregate_failures 'for admin' do
        scope = V2::EmployeePolicy::Scope.new(admin, Employee).resolve

        expect(scope.ids).to contain_exactly(employee1.id, employee2.id)
      end

      aggregate_failures 'for recruiter' do
        scope = V2::EmployeePolicy::Scope.new(recruiter, Employee).resolve

        expect(scope.ids).to contain_exactly(employee1.id, employee2.id)
      end

      aggregate_failures 'for evaluator' do
        scope = V2::EmployeePolicy::Scope.new(evaluator, Employee).resolve

        expect(scope.ids).to contain_exactly(employee2.id)
      end
    end
  end

  permissions :create?, :archive?, :update?, :archived?, :overview? do
    it 'provide correct priviledges' do
      aggregate_failures 'for admin' do
        expect(described_class).to permit(admin, Employee)
      end

      aggregate_failures 'for recruiter' do
        expect(described_class).to permit(recruiter, Employee)
      end

      aggregate_failures 'for evaluator' do
        expect(described_class).not_to permit(evaluator, Employee)
      end
    end
  end

  permissions :destroy? do
    it 'provide correct priviledges' do
      aggregate_failures 'for admin' do
        expect(described_class).to permit(admin, Employee)
      end

      aggregate_failures 'for recruiter' do
        expect(described_class).not_to permit(recruiter, Employee)
      end

      aggregate_failures 'for evaluator' do
        expect(described_class).not_to permit(evaluator, Employee)
      end
    end
  end
end
