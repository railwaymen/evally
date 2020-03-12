# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Browse::EvaluationsController, type: :controller do
  describe '#show' do
    it 'responds with evaluation' do
      employee = FactoryBot.create(:employee)

      evaluation = FactoryBot.create(
        :evaluation_completed_employee,
        evaluable: employee
      )

      FactoryBot.create(:section, sectionable: evaluation)

      get :show, params: { employee_id: employee.public_token, id: evaluation.id }

      expect(response).to have_http_status 200
      expect(response.body).to be_json_eql evaluation_employable_schema(evaluation)
    end

    it 'responds with not found error if invalid employee' do
      get :show, params: { employee_id: 1, id: 1 }

      expect(response).to have_http_status 404
    end

    it 'responds with not found error if invalid evaluation' do
      employee = FactoryBot.create(:employee)

      get :show, params: { employee_id: employee.public_token, id: 1 }

      expect(response).to have_http_status 404
    end
  end
end
