# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EvaluationRecruitablesController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :show, params: { recruit_id: 1, id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with evaluation' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)
        FactoryBot.create(:section, sectionable: evaluation)

        sign_in admin
        get :show, params: { recruit_id: recruit.id, id: evaluation.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql evaluation_recruitable_schema(evaluation)
      end

      it 'responds with 404 error' do
        sign_in admin

        aggregate_failures 'id recruit is missing' do
          get :show, params: { recruit_id: 1, id: 1 }
          expect(response).to have_http_status 404
        end

        aggregate_failures 'id evaluation is missing' do
          recruit_document = FactoryBot.create(:recruit_document)
          recruit = recruit_document.recruit

          get :show, params: { recruit_id: recruit.id, id: 1 }
          expect(response).to have_http_status 404
        end
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          evaluation: {
            recruit_id: 1,
            template_id: 1
          }
        }

        post :create, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with new evaluation' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        template = FactoryBot.create(:template, destination: 'recruits')
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            recruit_id: recruit.human_resources_id,
            template_id: template.id
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Evaluation.recruitable.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql(
          evaluation_recruitable_schema(recruit.evaluations.draft.last)
        )
      end

      it 'responds with 404 error if recruit not found' do
        template = FactoryBot.create(:template, destination: 'recruits')
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            recruit_id: 1,
            template_id: template.id
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.not_to(change { Evaluation.recruitable.count })

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Recruit does not exist'
      end

      it 'responds with 404 error if template not found' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        params = {
          evaluation: {
            recruit_id: recruit.human_resources_id,
            template_id: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.not_to(change { Evaluation.recruitable.count })

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Template does not exist'
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          id: 1,
          evaluation: {
            sections: [
              {
                id: 1,
                name: 'New section name'
              }
            ]
          }
        }

        put :update, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with updated evaluation' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)
        section = FactoryBot.create(:section, sectionable: evaluation)

        params = {
          id: evaluation.id,
          evaluation: {
            sections: [
              {
                id: section.id,
                skills: [
                  {
                    name: 'Description',
                    value: 'New value',
                    needToImprove: false
                  }
                ]
              }
            ]
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { section.reload.skills.first['value'] }.to('New value'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql evaluation_recruitable_schema(evaluation.reload)
      end

      it 'responds with error if invalid section' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)
        section = FactoryBot.create(:section, sectionable: evaluation)

        params = {
          id: evaluation.id,
          evaluation: {
            sections: [
              {
                id: section.id,
                skills: [
                  {
                    random: 'parameter'
                  }
                ]
              }
            ]
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Sections skills must have name and value'
      end
    end
  end

  describe '#destroy' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with no content' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)
        FactoryBot.create(:section, sectionable: evaluation)

        sign_in admin

        expect do
          delete :destroy, params: { id: evaluation.id }
        end.to(change { Evaluation.recruitable.draft.count }.by(-1))

        expect(response).to have_http_status 204
      end

      it 'responds with 404 error' do
        sign_in admin
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end
end
