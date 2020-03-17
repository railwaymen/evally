# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitDocumentPolicy, type: :policy do
  describe 'scope' do
    it 'returns correct scope' do
      admin = FactoryBot.create(:user, role: 'admin')
      recruiter = FactoryBot.create(:user, role: 'recruiter')
      evaluator = FactoryBot.create(:user, role: 'evaluator')

      recruit_document1 = FactoryBot.create(:recruit_document)

      recruit_document2 = FactoryBot.create(:recruit_document)
      recruit_document2.recruit.update(evaluator: evaluator)

      aggregate_failures 'for admin' do
        scope = Pundit.policy_scope!(admin, [:v2, RecruitDocument])

        expect(scope.ids).to contain_exactly(recruit_document1.id, recruit_document2.id)
      end

      aggregate_failures 'for recruiter' do
        scope = Pundit.policy_scope!(recruiter, [:v2, RecruitDocument])

        expect(scope.ids).to contain_exactly(recruit_document1.id, recruit_document2.id)
      end

      aggregate_failures 'for evaluator' do
        scope = Pundit.policy_scope!(evaluator, [:v2, RecruitDocument])

        expect(scope.ids).to contain_exactly(recruit_document2.id)
      end
    end
  end
end
