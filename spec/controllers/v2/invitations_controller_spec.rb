# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::InvitationsController, type: :controller do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          invitation: {
            email: 'invited@example.com',
            first_name: 'Jerry',
            last_name: 'Sparks',
            role: 'evaluator'
          }
        }

        post :create, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with new user' do
        params = {
          invitation: {
            email: 'invited@example.com',
            first_name: 'Jerry',
            last_name: 'Sparks',
            role: 'evaluator'
          }
        }

        sign_in user

        expect do
          post :create, params: params
        end.to(change { User.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql user_schema(User.last)
      end

      it 'sends invitation email' do
        params = {
          invitation: {
            email: 'invited@example.com',
            first_name: 'Jerry',
            last_name: 'Sparks',
            role: 'evaluator'
          }
        }

        sign_in user

        expect do
          post :create, params: params
        end.to(change { ActionMailer::Base.deliveries.count }.by(1))

        expect(ActionMailer::Base.deliveries.last[:to].value).to eq 'invited@example.com'
      end

      it 'create proper activity' do
        params = {
          invitation: {
            email: 'invited@example.com',
            first_name: 'Jerry',
            last_name: 'Sparks',
            role: 'evaluator'
          }
        }

        sign_in user

        expect do
          post :create, params: params
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'create',
          activable_name: 'Jerry Sparks'
        )
      end

      it 'responds with validation error' do
        params = {
          invitation: {
            email: 'invited@example.com',
            first_name: 'Jerry',
            last_name: ''
          }
        }

        sign_in user
        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Last name can\'t be blank'
      end
    end
  end
end
