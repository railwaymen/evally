require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe '#create' do

    let(:params) { attributes_for(:user) }

    context 'without authentication' do

      it 'expects to create new user', :aggregate_failures do
        expect do
          post :create, params: { user: params }
        end.to change { User.count }.by 1

        expect_success_api_response_for('user')
      end

      it 'expects to respond with error when invalid email', :aggregate_failures do
        params[:email] = 'invalid@email'

        expect do
          post :create, params: { user: params }
        end.not_to change { User.count }

        expect_error_api_response('422')
      end

      it 'expects to respond with error when invalid password', :aggregate_failures do
        params[:password] = '123ab'

        expect do
          post :create, params: { user: params }
        end.not_to change { User.count }

        expect_error_api_response('422')
      end
    end
  end
end
