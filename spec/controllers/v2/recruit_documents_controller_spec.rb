# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitDocumentsController, type: :controller do
  let(:recruiter) { create(:user, role: 'recruiter') }
  let(:evaluator) { create(:user, role: 'evaluator') }

  describe '#new' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :new
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        sign_in evaluator

        get :new
        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with statuses, groups, positions and evaluators' do
        FactoryBot.create(:recruit_document, group: 'Ruby', position: 'Junior Dev')

        sign_in recruiter
        get :new

        expect(response).to have_http_status 200
        expect(json_response['statuses']).to contain_exactly(*RecruitDocument.statuses.keys)
        expect(json_response['groups']).to contain_exactly 'Ruby'
        expect(json_response['positions']).to contain_exactly 'Junior Dev'
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          recruit_document: {
            first_name: 'Franek'
          }
        }

        post :create, params: params
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        params = {
          recruit_document: {
            first_name: 'Franek'
          }
        }

        sign_in evaluator

        post :create, params: params
        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'creates recruit, recruit document and responds 201' do
        params = {
          recruit_document: {
            first_name: 'Franek',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: 'Ruby',
            received_at: 1.minute.ago.to_s,
            source: 'website',
            accept_current_process: '1',
            accept_future_processes: '0'
          }
        }

        sign_in recruiter

        expect do
          post :create, params: params
        end.to(change { Recruit.count }.by(1).and(change { RecruitDocument.count }.by(1)))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql recruit_document_schema(RecruitDocument.last)
      end

      it 'creates proper activity' do
        params = {
          recruit_document: {
            first_name: 'Franek',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: 'Ruby',
            received_at: 1.minute.ago.to_s,
            source: 'website'
          }
        }

        sign_in recruiter

        expect do
          post :create, params: params
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'create',
          activable_name: 'Junior RoR Dev'
        )
      end

      it 'responds with 422 if invalid recruit document' do
        params = {
          recruit_document: {
            first_name: '',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: 'Ruby',
            received_at: 1.minute.ago.to_s,
            source: 'website'
          }
        }

        sign_in recruiter

        expect do
          post :create, params: params
        end.not_to(change { RecruitDocument.count })

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'First name can\'t be blank'
      end
    end
  end

  describe '#edit' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :edit, params: { id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        sign_in evaluator

        get :edit, params: { id: 1 }
        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with recruit document, statuses, groups, positions and evaluators' do
        recruit_document = FactoryBot.create(
          :recruit_document,
          group: 'Ruby',
          position: 'Junior Dev'
        )

        sign_in recruiter
        get :edit, params: { id: recruit_document.id }

        expect(response).to have_http_status 200
        expect(json_response['statuses']).to contain_exactly(*RecruitDocument.statuses.keys)
        expect(json_response['groups']).to contain_exactly 'Ruby'
        expect(json_response['positions']).to contain_exactly 'Junior Dev'
        expect(json_response['recruit_document'].to_json).to be_json_eql(
          recruit_document_schema(recruit_document)
        )
      end

      it 'responds with 404 if no recruit document' do
        sign_in recruiter
        get :edit, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          id: 1,
          recruit_document: {
            first_name: 'Franek'
          }
        }

        put :update, params: params
        expect(response).to have_http_status 401
      end

      it 'responds with 403' do
        params = {
          id: 1,
          recruit_document: {
            first_name: 'Franek'
          }
        }

        sign_in evaluator

        put :update, params: params
        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'updates recruit document' do
        recruit_document = FactoryBot.create(:recruit_document)

        params = {
          id: recruit_document.id,
          recruit_document: {
            group: 'Designers'
          }
        }

        sign_in recruiter

        expect do
          put :update, params: params

          recruit_document.reload
        end.to(change { recruit_document.group }.to('Designers'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql recruit_document_schema(recruit_document)
      end

      it 'creates proper activity' do
        recruit_document = FactoryBot.create(:recruit_document)

        params = {
          id: recruit_document.id,
          recruit_document: {
            position: 'Junior Designer'
          }
        }

        sign_in recruiter

        expect do
          put :update, params: params
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'update',
          activable_name: 'Junior Designer'
        )
      end

      it 'responds with 422 if invalid recruit document params' do
        recruit_document = FactoryBot.create(:recruit_document)

        params = {
          id: recruit_document.id,
          recruit_document: {
            group: ''
          }
        }

        sign_in recruiter

        expect do
          put :update, params: params
        end.not_to(change { recruit_document.reload.group })

        expect(response).to have_http_status 422
      end

      it 'responds with 404 if recruitment not found' do
        params = {
          id: 1,
          recruit_document: {
            first_name: 'Szczepan',
            group: 'Designers'
          }
        }

        sign_in recruiter
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end
  end
end
