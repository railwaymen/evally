# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitDocumentsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty recruit_documents, groups and statuses' do
        sign_in admin
        get :index

        expect(response).to have_http_status 200
        expect(json_response.keys).to contain_exactly(
          'recruit_documents',
          'groups',
          'statuses'
        )
      end

      it 'responds with serialized recruit_documents' do
        FactoryBot.create(:recruit_document)

        sign_in admin
        get :index

        expect(response).to have_http_status 200
        expect(response.body).to have_json_size(1).at_path('recruit_documents')
      end

      it 'responds with recruit_documents by group' do
        recruit_document1 = FactoryBot.create(:recruit_document, group: 'Ruby')
        FactoryBot.create(:recruit_document, group: 'Android')

        sign_in admin
        get :index, params: { group: 'Ruby' }

        expect(response).to have_http_status 200

        expect(response.body).to have_json_size(1).at_path('recruit_documents')
        expect(json_response['recruit_documents'].map { |r| r['id'] }).to contain_exactly(
          recruit_document1.id
        )
      end

      it 'responds with recruit_documents by status' do
        recruit_document1 = FactoryBot.create(:recruit_document, status: 'accepted')
        FactoryBot.create(:recruit_document, status: 'fresh')

        sign_in admin
        get :index, params: { status: 'accepted' }

        expect(response).to have_http_status 200

        expect(response.body).to have_json_size(1).at_path('recruit_documents')
        expect(json_response['recruit_documents'].map { |r| r['id'] }).to contain_exactly(
          recruit_document1.id
        )
      end
    end
  end

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :show, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with recruit_document' do
        recruit_document = FactoryBot.create(:recruit_document)

        sign_in admin
        get :show, params: { id: recruit_document.id }

        expect(response).to have_http_status 200
        expect(json_response['recruit_document'].to_json).to be_json_eql(
          recruit_document_schema(recruit_document)
        )
      end

      it 'responds with 404 if invalid recruit_document' do
        sign_in admin
        get :show, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end
end
