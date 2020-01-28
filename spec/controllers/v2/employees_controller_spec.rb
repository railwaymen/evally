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
end
