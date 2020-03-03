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

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :show, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with recruitment' do
        candidate = FactoryBot.create(:candidate)
        recruitment = FactoryBot.create(:recruitment, candidate: candidate)

        sign_in admin
        get :show, params: { id: recruitment.id }

        expect(response).to have_http_status 200
        expect(json_response['recruitment'].to_json).to be_json_eql recruitment_schema(recruitment)
      end

      it 'responds with 404 if invalid recruitment' do
        sign_in admin
        get :show, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          recruitment: {
            first_name: 'Franek',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: 'Ruby',
            received_at: 1.minute.ago.to_s,
            social_links: {
              linked_in: 'http://linkedin.com/fkimono'
            },
            source: 'website',
            evaluator_id: admin.id
          }
        }

        post :create, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'creates candidate and his recruitment and responds 201' do
        params = {
          recruitment: {
            first_name: 'Franek',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: 'Ruby',
            received_at: 1.minute.ago.to_s,
            social_links: {
              linked_in: 'http://linkedin.com/fkimono'
            },
            source: 'website',
            evaluator_id: admin.id
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Candidate.count }.by(1).and(change { Recruitment.count }.by(1)))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql recruitment_schema(Recruitment.last)
      end

      it 'creates proper activity' do
        params = {
          recruitment: {
            first_name: 'Franek',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: 'Ruby',
            received_at: 1.minute.ago.to_s,
            social_links: {
              linked_in: 'http://linkedin.com/fkimono'
            },
            source: 'website',
            evaluator_id: admin.id
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'create',
          activable_name: 'Franek Kimono'
        )
      end

      it 'responds with 422 if invalid candidate' do
        params = {
          recruitment: {
            first_name: '',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: 'Ruby',
            received_at: 1.minute.ago.to_s,
            social_links: {
              linked_in: 'http://linkedin.com/fkimono'
            },
            source: 'website',
            evaluator_id: admin.id
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.not_to(change { Candidate.count })

        expect(json_response['details'].first).to eq 'First name can\'t be blank'
      end

      it 'responds with 422 if invalid recruitment' do
        params = {
          recruitment: {
            first_name: 'Franek',
            last_name: 'Kimono',
            email: 'fkimono@example.com',
            gender: 'male',
            phone: '000-000-000',
            status: 'fresh',
            position: 'Junior RoR Dev',
            group: '',
            received_at: 1.minute.ago.to_s,
            social_links: {
              linked_in: 'http://linkedin.com/fkimono'
            },
            source: 'website',
            evaluator_id: admin.id
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.not_to(change { Recruitment.count })

        expect(json_response['details'].first).to eq 'Group can\'t be blank'
      end
    end
  end
end
