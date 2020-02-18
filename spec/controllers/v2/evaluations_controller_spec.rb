# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EvaluationsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }
  let(:evaluator) { create(:user, role: 'evaluator') }

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :show, params: { employee_id: 1, id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        evaluation = FactoryBot.create(:evaluation, :completed)
        FactoryBot.create(:section, sectionable: evaluation)

        sign_in evaluator
        get :show, params: { employee_id: evaluation.employee_id, id: evaluation.id }

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with evaluation' do
        evaluation = FactoryBot.create(:evaluation, :completed)
        FactoryBot.create(:section, sectionable: evaluation)

        sign_in admin
        get :show, params: { employee_id: evaluation.employee_id, id: evaluation.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql evaluation_schema(evaluation)
      end

      it 'responds with 404 error' do
        sign_in admin
        get :show, params: { employee_id: 1, id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end
end
