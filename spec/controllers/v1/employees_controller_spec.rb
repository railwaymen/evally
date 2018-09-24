require 'rails_helper'

RSpec.describe V1::EmployeesController, type: :controller do
  describe '#index'do

    let(:user) { create(:user_with_employees) }

    context 'when unauthorized' do
      it 'expectes to return 401 response' do
        sign_out

        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully' do
        get :index
        expect_success_api_response_for('employees')
      end

      it 'expects to return only current_user employees' do
        expect do
          create(:user_with_employees)
        end.to change(Employee, :count).from(5).to(10)

        get :index
        expect(json_response['data'].count).to eq user.employees.count
      end
    end
  end
end
