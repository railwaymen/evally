require 'rails_helper'

RSpec.describe V1::EmployeesController, type: :controller do

  let(:user) { create(:user_with_employees) }

  describe '#index'do

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

  describe '#create' do
    let(:employee_params) { attributes_for(:employee) }

    context 'when unauthorized' do
      it 'is not allowed to create employee' do
        sign_out

        post :create, params: { employee: employee_params }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully with new employee' do
        expect do
          post :create, params: { employee: employee_params }
        end.to change(user.employees, :count).by 1

        expect_success_api_response_for('employee')
      end

      it 'responds with error when invalid params' do
        params = attributes_for(:employee, first_name: '')

        expect do
          post :create, params: { employee: params }
        end.not_to change(user.employees, :count)

        expect_error_api_response(422)
      end
    end
  end

  describe '#update' do
    let(:employee) { user.employees.last }
    let!(:params) { { id: employee.id, employee: { first_name: 'Szczepan' } } }

    context 'when unauthorized' do
      it 'is not allowed to update employee' do
        sign_out

        put :update, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully with updated employee' do
        expect do
          put :update, params: params
        end.to change{ employee.reload.first_name }.to 'Szczepan'

        expect_success_api_response_for('employee')
      end

      it 'responds with error when employee not found' do
        params[:id] = 0

        expect do
          put :update, params: params
        end.not_to change{ employee.reload.first_name }

        expect_error_api_response(404)
      end

      it 'responds with error when invalid params' do
        params[:employee][:first_name] = ''

        expect do
          put :update, params: params
        end.not_to change{ employee.reload.first_name }

        expect_error_api_response(422)
      end
    end
  end

  describe '#destroy' do
    let(:employee) { user.employees.last }

    context 'when unauthorized' do
      it 'is not allowed to delete employee' do
        sign_out

        delete :destroy, params: { id: employee.id }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds with error when employee not found' do
        expect do
          delete :destroy, params: { id: 0 }
        end.not_to change{ user.employees.count }

        expect_error_api_response(404)
      end

      it 'deletes employee and rsponds with 204' do
        expect do
          delete :destroy, params: { id: employee.id }
        end.to change{ user.employees.count }.by -1

        expect(response).to have_http_status 204
      end
    end
  end
end
