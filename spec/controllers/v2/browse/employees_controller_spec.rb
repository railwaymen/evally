# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Browse::EmployeesController, type: :controller do
  describe '#show' do
    it 'responds with employee' do
      employee = FactoryBot.create(:employee)

      get :show, params: { id: employee.public_token }

      expect(response).to have_http_status 200
      expect(json_response['employee'].to_json).to be_json_eql employee_schema(employee)
    end

    it 'responds with not found error if invalid employee' do
      get :show, params: { id: 1 }

      expect(response).to have_http_status 404
    end
  end
end
