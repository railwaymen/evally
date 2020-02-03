# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::ProfileController, type: :controller do
  let(:user) { create(:user) }

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        sign_out

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

        sign_out
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
    end
  end
end
