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
      it 'responds with employees, drafts, activities and templates' do
        sign_in user

        get :show

        expect(response.body).to have_json_path('drafts')
        expect(response.body).to have_json_path('employees')
        expect(response.body).to have_json_path('templates')
        expect(response.body).to have_json_path('activities')
      end

      it 'responds 200 in response' do
        sign_in user

        get :show
        expect(response).to have_http_status 200
      end
    end
  end
end
