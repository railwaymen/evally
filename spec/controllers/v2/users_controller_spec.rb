# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::UsersController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty users' do
        sign_in user
        get :index

        expect(response).to have_http_status 200
      end
    end
  end
end
