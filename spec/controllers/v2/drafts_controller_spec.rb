# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::DraftsController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        sign_out

        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty drafts, employees and templates' do
        sign_in user
        get :index

        expect(response).to have_http_status 200
        expect(json_response).to include('drafts', 'employees', 'templates')
      end
    end
  end

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        sign_out

        get :show, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with draft' do
        draft = FactoryBot.create(:evaluation, :draft)

        sign_in user
        get :show, params: { id: draft.id }

        expect(response).to have_http_status 200
      end
    end
  end
end
