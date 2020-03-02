# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitmentsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty recruitments, groups and statuses' do
        sign_in admin
        get :index

        expect(response).to have_http_status 200
        expect(json_response.keys).to contain_exactly(
          'recruitments',
          'groups',
          'statuses'
        )
      end

      it 'responds with serialized recruitments' do
        candidate = FactoryBot.create(:candidate)
        FactoryBot.create(:recruitment, candidate: candidate)

        sign_in admin
        get :index

        expect(response).to have_http_status 200
        expect(response.body).to have_json_size(1).at_path('recruitments')
      end
    end
  end
end
