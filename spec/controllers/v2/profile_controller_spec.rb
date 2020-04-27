# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::ProfileController, type: :controller do
  let(:user) { create(:user) }

  before(:each) { stub_api_client_service }

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :show
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with user and his settings' do
        sign_in user

        get :show

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql profile_schema(user)
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          profile: {
            first_name: 'Jack'
          }
        }

        put :update, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'expects to update user' do
        params = {
          profile: {
            first_name: 'Szczepan',
            last_name: 'Kowalski'
          }
        }

        sign_in user

        expect do
          put :update, params: params
        end.to(change { user.reload.first_name }.to('Szczepan'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql user_schema(user)
      end

      it 'responds with error if invalid profile' do
        params = {
          profile: {
            first_name: ''
          }
        }

        sign_in user
        put :update, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'First name can\'t be blank'
      end
    end
  end

  describe '#password' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          profile: {
            new_password: 'newpassword',
            password_confirmation: 'newpassword',
            password: 'password'
          }
        }

        put :password, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'updates password' do
        params = {
          profile: {
            new_password: 'newpassword',
            password_confirmation: 'newpassword',
            password: 'password'
          }
        }

        sign_in user

        expect do
          put :password, params: params
        end.to(change { user.reload.encrypted_password })

        expect(response).to have_http_status 204
      end

      it 'responds with invalid password error' do
        params = {
          profile: {
            new_password: 'newpassword',
            password_confirmation: 'newpassword',
            password: 'wrongpassword'
          }
        }

        sign_in user

        expect do
          put :password, params: params
        end.not_to(change { user.reload.password })

        expect(response).to have_http_status 422
        expect(json_response['details']).to contain_exactly 'Password is invalid'
      end

      it 'responds with too short error' do
        params = {
          profile: {
            new_password: '12345',
            password_confirmation: '12345',
            password: 'password'
          }
        }

        sign_in user

        expect do
          put :password, params: params
        end.not_to(change { user.reload.password })

        expect(response).to have_http_status 422
        expect(json_response['details']).to contain_exactly(
          'Password length must be between 6 and 32 characters'
        )
      end

      it 'responds with unconfirmed error' do
        params = {
          profile: {
            new_password: 'newpassword',
            password_confirmation: 'unconfirmed',
            password: 'password'
          }
        }

        sign_in user

        expect do
          put :password, params: params
        end.not_to(change { user.reload.password })

        expect(response).to have_http_status 422
        expect(json_response['details']).to contain_exactly 'Password confirmation does not match'
      end
    end
  end
end
