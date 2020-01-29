# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmployeesController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        sign_out

        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty employees' do
        sign_in user
        get :index

        expect(response).to have_http_status 200

        expect(response.body).to be_json_eql('[]')
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          employee: {
            first_name: 'John',
            last_name: 'Doe',
            position: 'Junior Specialist',
            group: 'Marketing',
            hired_at: 1.month.ago,
            position_set_at: 1.month.ago
          }
        }

        sign_out

        post :create, params: params
        expect(response).to have_http_status 401
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
            hired_at: 1.month.ago,
            position_set_at: 1.month.ago
          }
        }

        sign_in user

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
            hired_at: 1.month.ago,
            position_set_at: 1.month.ago
          }
        }

        sign_in user

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
            hired_at: 1.month.ago
          }
        }

        sign_in user

        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'First name can\'t be blank'
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          id: 1,
          employee: {
            first_name: 'New name'
          }
        }

        sign_out
        put :update, params: params

        expect(response).to have_http_status 401
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

        sign_in user
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
            position_set_at: Time.zone.today
          }
        }

        sign_in user

        expect do
          put :update, params: params
        end.to(change { employee.position_changes.count }.by(1))

        expect(employee.position_changes.last).to have_attributes(
          previous_position: 'Junior Specialist',
          current_position: 'Senior Specialist',
          changed_at: params.dig(:employee, :position_set_at)
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

        sign_in user

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

        sign_in user

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

        sign_in user
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end
  end
end