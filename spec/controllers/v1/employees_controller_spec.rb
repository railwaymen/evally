# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::EmployeesController, type: :controller do
  let(:user) { create(:user_with_employees) }

  describe '#index' do
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

      it 'expects to return all employees' do
        expect do
          create(:user_with_employees)
        end.to change(Employee, :count).from(5).to(10)

        get :index
        expect(json_response.count).to eq Employee.count
      end
    end
  end

  describe '#show' do
    let(:employee) { user.employees.last }

    context 'when unauthorized' do
      it 'expectes to return 401 response' do
        sign_out

        get :show, params: { id: employee.id }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully' do
        get :show, params: { id: employee.id }
        expect_success_api_response_for('employee')
      end

      it 'responds with not found error' do
        get :show, params: { id: 0 }
        expect_error_api_response(404)
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
        end.to change { employee.reload.first_name }.to 'Szczepan'

        expect_success_api_response_for('employee')
      end

      it 'expects to log position change' do
        expect do
          put :update, params: {
            id: employee.id,
            employee: {
              position: 'New position',
              position_set_at: Date.current
            }
          }
        end.to change { employee.reload.position_changes.count }.by(1)

        expect_success_api_response_for('employee')
      end

      it 'responds with error when employee not found' do
        params[:id] = 0

        expect do
          put :update, params: params
        end.not_to change { employee.reload.first_name }

        expect_error_api_response(404)
      end

      it 'responds with error when invalid params' do
        params[:employee][:first_name] = ''

        expect do
          put :update, params: params
        end.not_to change { employee.reload.first_name }

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
        end.not_to change { user.employees.count }

        expect_error_api_response(404)
      end

      it 'deletes employee and rsponds with 204' do
        expect do
          delete :destroy, params: { id: employee.id }
        end.to change { user.employees.count }.by(-1)

        expect(response).to have_http_status 204
      end
    end
  end

  describe '#chart' do
    let(:user) { create(:user) }

    context 'when unauthorized' do
      it 'is not allowed to get chart data' do
        sign_out

        get :chart
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) { sign_in user }

      it 'returns empty hash if no data' do
        get :chart
        expect(response).to have_http_status 200

        expect(json_response).to be_blank
      end

      it 'returns data with specified template' do
        [
          { group: 'Ruby', position: 'Ruby Developer', amount: 2 },
          { group: 'Ruby', position: 'Senior Ruby Developer', amount: 3 },
          { group: 'Ruby', position: 'Junior Ruby Developer', amount: 1 },
          { group: 'Android', position: 'Senior Android Developer', amount: 4 },
          { group: 'Android', position: 'Android Developer', amount: 2 },
          { group: 'Support', position: 'Office Manager', amount: 1 }
        ].each do |set|
          set[:amount].times { create(:employee, group: set[:group], position: set[:position]) }
        end

        get :chart
        expect(response).to have_http_status 200

        expect(json_response['Android']).to contain_exactly(
          ['Android Developer', 2], ['Senior Android Developer', 4]
        )

        expect(json_response['Ruby']).to contain_exactly(
          ['Junior Ruby Developer', 1], ['Ruby Developer', 2], ['Senior Ruby Developer', 3]
        )

        expect(json_response['Support']).to contain_exactly(['Office Manager', 1])
      end
    end
  end

  describe '#skills' do
    let(:user) { create(:user) }

    context 'when unauthorized' do
      it 'is not allowed to get unique skills list' do
        sign_out

        get :skills
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      let!(:template) { create(:draft_template, name: 'S1') }
      let!(:evaluation) { create(:evaluation_with_sections, :completed) }

      it 'returns list of unique skills' do
        sign_in user

        get :skills
        expect(response).to have_http_status 200

        expect(json_response['rating']).to contain_exactly(
          'Photoshop', 'Illustrator', 'CorelDraw', 'Paint', 'Visual Code'
        )

        expect(json_response['bool']).to contain_exactly(
          'Time', 'Cooperation', 'Relations'
        )
      end
    end
  end

  describe '#search' do
    let(:user) { create(:user) }

    context 'when unauthorized' do
      it 'is not allowed to get unique skills list' do
        sign_out

        get :search, params: {
          query: {
            group: 'rating',
            name: 'Photoshop',
            comparator: 'eq',
            value: 1
          }
        }

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      let(:employee_1) { create(:employee, user: user) }
      let(:employee_2) { create(:employee, user: user) }

      let!(:evaluation_one) { create(:evaluation, :completed, employee: employee_1) }
      let!(:evaluation_two) { create(:evaluation, :completed, employee: employee_2) }

      let!(:evaluation_one_rating_section) do
        create(
          :section,
          :rating,
          sectionable: evaluation_one,
          skills: [
            { name: 'Photoshop', value: 1, needToImprove: false },
            { name: 'Illustrator', value: 3, needToImprove: false }
          ]
        )
      end

      let!(:evaluation_one_bool_section) do
        create(
          :section,
          :bool,
          sectionable: evaluation_one,
          skills: [
            { name: 'Time', value: false, needToImprove: false }
          ]
        )
      end

      let!(:evaluation_two_rating_section) do
        create(
          :section,
          :rating,
          sectionable: evaluation_two,
          skills: [
            { name: 'Photoshop', value: 2, needToImprove: false },
            { name: 'Illustrator', value: 3, needToImprove: false }
          ]
        )
      end

      let!(:evaluation_two_bool_section) do
        create(
          :section,
          :bool,
          sectionable: evaluation_two,
          skills: [
            { name: 'Time', value: true, needToImprove: false }
          ]
        )
      end

      before(:each) { sign_in user }

      it 'returns empty array if no employees with skill' do
        get :search, params: {
          query: {
            group: 'rating',
            name: 'Unknown',
            comparator: 'eq',
            value: 1
          }
        }

        expect(response).to have_http_status 200
        expect(json_response).to be_blank
      end

      it 'returns correct employees', :aggregate_failures do
        aggregate_failures 'with Photoshop star equal to 1' do
          query = { group: 'rating', name: 'Photoshop', comparator: 'eq', value: 1 }

          get :search, params: { query: query }

          expect_success_api_response_for('employees')
          expect(json_response.length).to eq 1

          expect(json_response.first['id']).to eq employee_1.id
        end

        aggregate_failures 'with Photoshop star greater than 1' do
          query = { group: 'rating', name: 'Photoshop', comparator: 'gteq', value: 1 }

          get :search, params: { query: query }

          expect_success_api_response_for('employees')
          expect(json_response.length).to eq 2
        end

        aggregate_failures 'with Illustrator star equal to 3' do
          query = { group: 'rating', name: 'Illustrator', comparator: 'eq', value: 3 }

          get :search, params: { query: query }

          expect_success_api_response_for('employees')
          expect(json_response.length).to eq 2
        end

        aggregate_failures 'with Illustrator star lower than 2' do
          query = { group: 'rating', name: 'Illustrator', comparator: 'lteq', value: 2 }

          get :search, params: { query: query }

          expect_success_api_response_for('employees')
          expect(json_response.length).to eq 0
        end

        aggregate_failures 'with Time equal to true' do
          query = { group: 'bool', name: 'Time', comparator: 'eq', value: 1 } # true -> 1

          get :search, params: { query: query }

          expect_success_api_response_for('employees')
          expect(json_response.length).to eq 1

          expect(json_response.first['id']).to eq employee_2.id
        end

        aggregate_failures 'with Time equal to false' do
          query = { group: 'bool', name: 'Time', comparator: 'eq', value: 0 } # false -> 0

          get :search, params: { query: query }

          expect_success_api_response_for('employees')
          expect(json_response.length).to eq 1

          expect(json_response.first['id']).to eq employee_1.id
        end
      end
    end
  end
end
