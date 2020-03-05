# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitmentsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

  xdescribe '#index' do
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

      it 'responds with recruitments by group' do
        candidate1 = FactoryBot.create(:candidate)
        recruitment1 = FactoryBot.create(:recruitment, group: 'Ruby', candidate: candidate1)

        candidate2 = FactoryBot.create(:candidate)
        FactoryBot.create(:recruitment, group: 'Android', candidate: candidate2)

        sign_in admin
        get :index, params: { group: 'Ruby' }

        expect(response).to have_http_status 200

        expect(response.body).to have_json_size(1).at_path('recruitments')
        expect(json_response['recruitments'].map { |r| r['id'] }).to contain_exactly recruitment1.id
      end

      it 'responds with recruitments by status' do
        candidate1 = FactoryBot.create(:candidate)
        recruitment1 = FactoryBot.create(:recruitment, status: 'ongoing', candidate: candidate1)

        candidate2 = FactoryBot.create(:candidate)
        FactoryBot.create(:recruitment, status: 'fresh', candidate: candidate2)

        sign_in admin
        get :index, params: { status: 'ongoing' }

        expect(response).to have_http_status 200

        expect(response.body).to have_json_size(1).at_path('recruitments')
        expect(json_response['recruitments'].map { |r| r['id'] }).to contain_exactly recruitment1.id
      end
    end
  end

  xdescribe '#show' do
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

  xdescribe '#create' do
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
          activable_name: 'Junior RoR Dev'
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

        expect(response).to have_http_status 422
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

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Group can\'t be blank'
      end
    end
  end

  xdescribe '#update' do
    context 'when unauthorized' do
      it 'responds with 401' do
        params = {
          id: 1,
          recruitment: {
            first_name: 'Franek'
          }
        }

        put :update, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'updates candidate params' do
        candidate = FactoryBot.create(:candidate)
        recruitment = FactoryBot.create(:recruitment, candidate: candidate)

        params = {
          id: recruitment.id,
          recruitment: {
            first_name: 'Szczepan'
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { candidate.reload.first_name }.to('Szczepan'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql recruitment_schema(recruitment.reload)
      end

      it 'updates requirement params' do
        candidate = FactoryBot.create(:candidate)
        recruitment = FactoryBot.create(:recruitment, candidate: candidate)

        params = {
          id: recruitment.id,
          recruitment: {
            group: 'Designers'
          }
        }

        sign_in admin

        expect do
          put :update, params: params

          recruitment.reload
        end.to(change { recruitment.group }.to('Designers'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql recruitment_schema(recruitment)
      end

      it 'creates proper activity' do
        candidate = FactoryBot.create(:candidate)
        recruitment = FactoryBot.create(:recruitment, candidate: candidate)

        params = {
          id: recruitment.id,
          recruitment: {
            position: 'Junior Designer'
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { Activity.count }.by(1))

        expect(Activity.last).to have_attributes(
          action: 'update',
          activable_name: 'Junior Designer'
        )
      end

      it 'responds with 422 if invalid candidate params' do
        candidate = FactoryBot.create(:candidate)
        recruitment = FactoryBot.create(:recruitment, candidate: candidate)

        params = {
          id: recruitment.id,
          recruitment: {
            first_name: ''
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.not_to(change { candidate.reload.first_name })

        expect(response).to have_http_status 422
      end

      it 'responds with 422 if invalid recruitment params' do
        candidate = FactoryBot.create(:candidate)
        recruitment = FactoryBot.create(:recruitment, candidate: candidate)

        params = {
          id: recruitment.id,
          recruitment: {
            group: ''
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.not_to(change { recruitment.reload.group })

        expect(response).to have_http_status 422
      end

      it 'responds with 404 if recruitment not found' do
        params = {
          id: 1,
          recruitment: {
            first_name: 'Szczepan',
            group: 'Designers'
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end
  end
end
