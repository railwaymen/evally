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

  describe '#show' do
    let(:user) { create(:user) }

    context 'when unauthorized' do
      it 'expectes to return 401 response' do
        sign_out

        get :show, params: { id: 'current' }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'expects to respond succesfully with own data' do
        sign_in user

        get :show, params: { id: 'current' }
        expect_success_api_response_for('user')

        expect(json_response['data']['attributes']['email']).to eq user.email
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let(:params) { { id: 'current', user: { first_name: 'Szczepan', last_name: 'Kowalski' } } }

    context 'when unauthorized' do
      it 'expectes to return 401 response' do
        sign_out

        put :update, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'expects to update own data' do
        expect do
          put :update, params: params
        end.to change{ user.reload.first_name }.to('Szczepan')

        expect_success_api_response_for('user')
      end
    end
  end

  describe '#password' do
    let(:user) { create(:user) }
    let(:params) { { id: 'current', password: { old_one: '1234qwer', new_one: 'password' } } }

    context 'when unauthorized' do
      it 'expectes to return 401 response' do
        sign_out

        put :password, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'expects to change password' do
        expect do
          put :password, params: params
        end.to change{ user.reload.password_digest }

        expect(response.status).to eq 200
      end

      it 'expects to respond with error when old password invalid' do
        params[:password][:old_one] = 'invalid'

        expect do
          put :password, params: params
        end.not_to change{ user.reload.password_digest }

        expect_error_api_response(422)
      end

      it 'expects to respond with error when new password invalid' do
        params[:password][:new_one] = '12345'

        expect do
          put :password, params: params
        end.not_to change{ user.reload.password_digest }

        expect_error_api_response(422)
      end
    end
  end
end
