# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitPolicy, type: :policy do
  describe 'scope' do
    it 'returns correct scope' do
      admin = FactoryBot.create(:user, role: 'admin')
      evaluator = FactoryBot.create(:user, role: 'evaluator')

      recruit1 = FactoryBot.create(:recruit)
      recruit2 = FactoryBot.create(:recruit, evaluator: evaluator)

      aggregate_failures 'for admin' do
        scope = V2::RecruitPolicy::Scope.new(admin, Recruit).resolve

        expect(scope.ids).to contain_exactly(recruit1.id, recruit2.id)
      end

      aggregate_failures 'for evaluator' do
        scope = V2::RecruitPolicy::Scope.new(evaluator, Recruit).resolve

        expect(scope.ids).to be_empty
      end
    end
  end
end
