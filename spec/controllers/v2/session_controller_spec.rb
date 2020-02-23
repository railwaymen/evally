# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::SessionController, type: :controller do
  describe '#create' do
    it 'responds with jwt token' do
      user = FactoryBot.create(:user, email: 'user@example.com', password: 'password')

      params = {
        session: {
          email: user.email,
          password: 'password'
        }
      }

      allow(Rails.application.credentials).to receive(:secret_key_base).and_return('abc')
      post :create, params: params

      expect(response).to have_http_status 201
      expect(response.body).to have_json_path('jwt')
    end

    it 'responds with 401 if user blank' do
      params = {
        session: {
          email: 'user@example.com',
          password: 'password'
        }
      }

      post :create, params: params
      expect(response).to have_http_status 401
    end

    it 'responds with 401 if wrong password' do
      user = FactoryBot.create(:user, email: 'user@example.com', password: 'password')

      params = {
        session: {
          email: user.email,
          password: 'wrongpassword'
        }
      }

      post :create, params: params
      expect(response).to have_http_status 401
    end

    it 'responds with 401 if user.inactive' do
      user = FactoryBot.create(
        :user,
        email: 'user@example.com',
        password: 'password',
        status: :inactive
      )

      params = {
        session: {
          email: user.email,
          password: 'password'
        }
      }

      post :create, params: params
      expect(response).to have_http_status 401
    end
  end
end
