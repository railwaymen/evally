# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitmentsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

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
