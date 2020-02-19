# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeesController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }
  let(:evaluator) { create(:user, role: 'evaluator') }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty employees' do
        sign_in admin
        get :index

        expect(response).to have_http_status 200

        expect(response.body).to have_json_path('employees')
        expect(response.body).to have_json_path('evaluators')
      end
    end
  end

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with employee' do
        employee = FactoryBot.create(:employee)

        sign_in admin
        get :show, params: { id: employee.id }

        expect(response).to have_http_status 200
        expect(json_response['employee'].to_json).to be_json_eql employee_schema(employee)
      end

      it 'responds with not found error if invalid employee' do
        sign_in admin
        get :show, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          employee: {
            first_name: 'John',
            last_name: 'Doe',
            position: 'Junior Specialist',
            group: 'Marketing',
            hired_on: 1.month.ago,
            position_set_on: 1.month.ago
          }
        }

        post :create, params: params
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        params = {
          employee: {
            first_name: 'John',
            last_name: 'Doe',
            position: 'Junior Specialist',
            group: 'Marketing',
            hired_on: 1.month.ago,
            position_set_on: 1.month.ago
          }
        }

        sign_in evaluator

        post :create, params: params
        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with new employee' do
        params = {
          employee: {
            first_name: 'John',
            last_name: 'Doe',
            position: 'Junior Specialist',
            group: 'Marketing',
            hired_on: 1.month.ago,
            position_set_on: 1.month.ago
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Employee.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql employee_schema(Employee.last)
      end

      it 'creates proper activity' do
        params = {
          employee: {
            first_name: 'John',
            last_name: 'Doe',
            position: 'Junior Specialist',
            group: 'Marketing',
            hired_on: 1.month.ago,
            position_set_on: 1.month.ago
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'create',
          activable_name: 'John Doe'
        )
      end

      it 'responds with validation error' do
        params = {
          employee: {
            first_name: '',
            last_name: 'Doe',
            position: 'Junior Specialist',
            group: 'Marketing',
            hired_on: 1.month.ago
          }
        }

        sign_in admin

        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'First name can\'t be blank'
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          id: 1,
          employee: {
            first_name: 'New name'
          }
        }

        put :update, params: params

        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        params = {
          id: 1,
          employee: {
            first_name: 'New name'
          }
        }

        sign_in evaluator
        put :update, params: params

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with updated employee' do
        employee = FactoryBot.create(:employee, first_name: 'Rob')

        params = {
          id: employee.id,
          employee: {
            first_name: 'Jack'
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql employee_schema(employee.reload)
      end

      it 'creates position change log' do
        employee = FactoryBot.create(:employee, position: 'Junior Specialist')

        params = {
          id: employee.id,
          employee: {
            position: 'Senior Specialist',
            position_set_on: Time.zone.today
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { employee.position_changes.count }.by(1))

        expect(employee.position_changes.last).to have_attributes(
          previous_position: 'Junior Specialist',
          current_position: 'Senior Specialist',
          changed_on: params.dig(:employee, :position_set_on)
        )
      end

      it 'creates proper activity' do
        employee = FactoryBot.create(:employee, first_name: 'Rob', last_name: 'Doe')

        params = {
          id: employee.id,
          employee: {
            first_name: 'Jack'
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'update',
          activable_name: 'Jack Doe'
        )
      end

      it 'responds with validation error' do
        employee = FactoryBot.create(:employee)

        params = {
          id: employee.id,
          employee: {
            first_name: ''
          }
        }

        sign_in admin

        put :update, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'First name can\'t be blank'
      end

      it 'responds with not found error' do
        params = {
          id: 1,
          employee: {
            first_name: 'Jack'
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#skills' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :skills
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with skills list' do
        evaluation = FactoryBot.create(:evaluation, :completed)

        FactoryBot.create(
          :section,
          group: 'rating',
          sectionable: evaluation,
          skills: [
            { name: 'Vim', value: 1, needToImprove: false }
          ]
        )

        FactoryBot.create(
          :section,
          group: 'bool',
          sectionable: evaluation,
          skills: [
            { name: 'Be a team leader', value: true, needToImprove: false }
          ]
        )

        sign_in admin
        get :skills

        expect(response).to have_http_status 200
        expect(json_response).to include(
          { 'group' => 'bool', 'name' => 'Be a team leader' },
          'group' => 'rating', 'name' => 'Vim'
        )
      end
    end
  end

  describe '#search' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :search
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with searched employee' do
        employee = FactoryBot.create(:employee)
        evaluation = FactoryBot.create(:evaluation, :completed, employee: employee)

        FactoryBot.create(
          :section,
          group: 'rating',
          sectionable: evaluation,
          skills: [
            { name: 'Vim', value: 1, needToImprove: false }
          ]
        )

        FactoryBot.create(
          :section,
          group: 'bool',
          sectionable: evaluation,
          skills: [
            { name: 'Be a team leader', value: true, needToImprove: false }
          ]
        )

        params = {
          group: 'rating',
          name: 'Vim',
          operator: 'eq',
          value: 1
        }

        sign_in admin
        get :search, params: params

        expect(response).to have_http_status 200
        expect(json_response.map { |r| r['id'] }).to include employee.id
      end

      it 'responds with empty array' do
        params = {
          group: 'rating',
          name: 'Vim',
          operator: 'eq',
          value: 1
        }

        sign_in admin
        get :search, params: params

        expect(response).to have_http_status 200
        expect(json_response).to eq []
      end
    end
  end

  describe '#overview' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :overview
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        sign_in evaluator

        get :overview
        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with positions chart data' do
        FactoryBot.create_list(
          :employee,
          2,
          position: 'Junior Specialist',
          group: 'Programmers',
          hired_on: 45.days.ago
        )

        FactoryBot.create(
          :employee,
          position: 'Senior Manager',
          group: 'Managers',
          hired_on: 45.days.ago
        )

        sign_in admin

        get :overview

        expect(response).to have_http_status 200
        expect(json_response).to eq(
          'analytics' => { 'average_employment' => 1.0 },
          'groups' => %w[Managers Programmers],
          'positions_chart_data' => [
            { 'group' => 'Managers', 'label' => 'Senior Manager', 'value' => 1 },
            { 'group' => 'Programmers', 'label' => 'Junior Specialist', 'value' => 2 }
          ]
        )
      end

      it 'responds with empty arrays in no employees' do
        sign_in admin
        get :overview

        expect(response).to have_http_status 200
        expect(json_response).to eq(
          'analytics' => { 'average_employment' => 0.0 },
          'groups' => [],
          'positions_chart_data' => []
        )
      end
    end
  end

  describe '#destroy' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        sign_in evaluator
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'removes employee and respond with no content' do
        employee = FactoryBot.create(:employee)

        sign_in admin

        expect do
          delete :destroy, params: { id: employee.id }
        end.to(change { Employee.count }.by(-1))

        expect(response).to have_http_status 204
      end

      it 'creates destroy activity' do
        employee = FactoryBot.create(:employee)

        sign_in admin

        expect do
          delete :destroy, params: { id: employee.id }
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'destroy',
          activable_name: employee.fullname
        )
      end

      it 'responds with not found' do
        sign_in admin
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end
end
