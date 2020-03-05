# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::RecruitmentsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

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
