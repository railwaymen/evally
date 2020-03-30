# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::SectionPolicy, type: :policy do
  describe 'scope' do
    it 'returns correct scope' do
      admin = FactoryBot.create(:user, role: 'admin')
      recruiter = FactoryBot.create(:user, role: 'recruiter')
      evaluator = FactoryBot.create(:user, role: 'evaluator')

      recruit = FactoryBot.create(:recruit)
      evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)

      open_section = FactoryBot.create(:section, sectionable: evaluation, sensitive: false)
      sensitive_section = FactoryBot.create(:section, sectionable: evaluation, sensitive: true)

      aggregate_failures 'for admin' do
        scope = V2::SectionPolicy::Scope.new(admin, evaluation.sections).resolve

        expect(scope.ids).to contain_exactly(open_section.id, sensitive_section.id)
      end

      aggregate_failures 'for recruiter' do
        scope = V2::SectionPolicy::Scope.new(recruiter, evaluation.sections).resolve

        expect(scope.ids).to contain_exactly(open_section.id, sensitive_section.id)
      end

      aggregate_failures 'for evaluator' do
        scope = V2::SectionPolicy::Scope.new(evaluator, evaluation.sections).resolve

        expect(scope.ids).to contain_exactly(open_section.id)
      end
    end
  end
end
