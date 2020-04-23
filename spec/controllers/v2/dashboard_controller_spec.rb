# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::DashboardController, type: :controller do
  let(:user) { create(:user) }

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :show

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with employees, drafts and activities' do
        sign_in user

        get :show

        expect(response).to have_http_status 200
        expect(json_response.keys).to contain_exactly(
          'employees', 'drafts', 'activities'
        )
      end
    end
  end
end
