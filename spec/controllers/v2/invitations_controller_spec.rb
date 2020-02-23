# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::InvitationsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }
  let(:evaluator) { create(:user, role: 'evaluator') }

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
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

      it 'responds with 403 error' do
        params = {
          invitation: {
            email: 'invited@example.com',
            first_name: 'Jerry',
            last_name: 'Sparks',
            role: 'evaluator'
          }
        }

        sign_in evaluator

        post :create, params: params
        expect(response).to have_http_status 403
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

        sign_in admin

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

        sign_in admin

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

        sign_in admin

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

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Last name can\'t be blank'
      end
    end
  end

  describe '#update' do
    it 'accepts invitation and setup password' do
      user = FactoryBot.create(:user)
      user.invite! { |u| u.skip_invitation = true }

      params = {
        id: user.invitation_token,
        invitation: {
          password: 'password',
          password_confirmation: 'password'
        }
      }

      expect do
        put :update, params: params
      end.to(change { user.reload.invitation_accepted_at }.from(nil))

      expect(response).to have_http_status 204
    end

    it 'responds with 404 if user inactive' do
      user = FactoryBot.create(:user, status: :inactive)
      user.invite! { |u| u.skip_invitation = true }

      params = {
        id: user.invitation_token,
        invitation: {
          password: 'password',
          password_confirmation: 'password'
        }
      }

      put :update, params: params
      expect(response).to have_http_status 404
    end

    it 'responds with 404 if invitation already accepted' do
      FactoryBot.create(
        :user,
        invitation_token: nil,
        invitation_created_at: 1.hour.ago,
        invitation_sent_at: 1.hour.ago,
        invitation_accepted_at: 1.minute.ago
      )

      params = {
        id: 'alreadyusedtoken',
        invitation: {
          password: 'password',
          password_confirmation: 'password'
        }
      }

      put :update, params: params
      expect(response).to have_http_status 404
    end

    it 'responds with 422 if invalid password' do
      user = FactoryBot.create(:user)
      user.invite! { |u| u.skip_invitation = true }

      params = {
        id: user.invitation_token,
        invitation: {
          password: 'pass',
          password_confirmation: 'pass'
        }
      }

      put :update, params: params

      expect(response).to have_http_status 422
      expect(json_response['details'].first).to eq(
        'Password length must be between 6 and 32 characters'
      )
    end

    it 'responds with 422 if password unconfirmed' do
      user = FactoryBot.create(:user)
      user.invite! { |u| u.skip_invitation = true }

      params = {
        id: user.invitation_token,
        invitation: {
          password: 'password',
          password_confirmation: 'unconfirmed'
        }
      }

      put :update, params: params

      expect(response).to have_http_status 422
      expect(json_response['details'].first).to eq(
        'Password confirmation does not match'
      )
    end
  end
end
