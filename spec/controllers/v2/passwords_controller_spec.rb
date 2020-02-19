# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::PasswordsController, type: :controller do
  describe '#create' do
    context 'when user is missing' do
      it 'responds with 404 error' do
        post :create, params: { password: { email: 'user@example.com' } }

        expect(response).to have_http_status 404
      end
    end

    context 'when user exists' do
      it 'creates reset password token' do
        user = FactoryBot.create(:user, email: 'user@example.com')

        expect do
          post :create, params: { password: { email: user.email } }
        end.to(change { user.reload.reset_password_token })

        expect(response).to have_http_status 204
      end

      it 'sends email' do
        user = FactoryBot.create(:user, email: 'user@example.com')

        expect do
          post :create, params: { password: { email: user.email } }
        end.to(change { ActionMailer::Base.deliveries.count }.by(1))

        expect(ActionMailer::Base.deliveries.last[:to].value).to eq 'user@example.com'
      end

      it 'responds with 422 error if send reset password instructions failed' do
        user = FactoryBot.create(:user, email: 'user@example.com')
        allow_any_instance_of(User).to receive(:send_reset_password_instructions).and_return(false)

        post :create, params: { password: { email: user.email } }

        expect(response).to have_http_status 422
      end
    end
  end

  describe '#update' do
    context 'when invalid token' do
      it 'responds with 404 error' do
        params = {
          reset_password_token: 'invalid',
          password: {
            password: '',
            password_confirmation: ''
          }
        }

        post :create, params: params

        expect(response).to have_http_status 404
      end
    end

    context 'when valid token' do
      it 'resets password' do
        user = FactoryBot.create(
          :user,
          password: 'password',
          reset_password_token: 'GfvD8fePf36A5nycUNr2WREN',
          reset_password_sent_at: 1.minute.ago
        )

        params = {
          id: user.reset_password_token,
          password: {
            password: 'new_password',
            password_confirmation: 'new_password'
          }
        }

        expect do
          put :update, params: params
        end.to(change { user.reload.password_digest })

        expect(response).to have_http_status 204
      end

      it 'responds with 422 error if invalid password' do
        user = FactoryBot.create(
          :user,
          password: 'password',
          reset_password_token: 'GfvD8fePf36A5nycUNr2WREN',
          reset_password_sent_at: 1.minute.ago
        )

        params = {
          id: user.reset_password_token,
          password: {
            password: 'short',
            password_confirmation: 'short'
          }
        }

        put :update, params: params

        expect(response).to have_http_status 422
      end
    end
  end
end
