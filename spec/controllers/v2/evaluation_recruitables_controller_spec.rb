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
        recruit = FactoryBot.create(:recruit)

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
          recruit = FactoryBot.create(:recruit)

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
            public_recruit_id: 1,
            template_id: 1,
            position: 'Ruby Developer'
          }
        }

        post :create, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with new evaluation' do
        recruit = FactoryBot.create(:recruit)

        template = FactoryBot.create(:template, destination: 'recruits')
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            public_recruit_id: recruit.public_recruit_id,
            recruit_document_id: 1,
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

      it 'creates proper notifications' do
        recruiter = FactoryBot.create(:user, role: :recruiter)

        recruit = FactoryBot.create(:recruit)
        evaluator = recruit.evaluator

        template = FactoryBot.create(:template, destination: 'recruits')
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            public_recruit_id: recruit.public_recruit_id,
            recruit_document_id: 1,
            template_id: template.id
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Notification.count }.by(2))

        evaluation = recruit.evaluations.last

        expect(evaluator.notifications.last).to have_attributes(
          action: 'start_recruit_evaluation',
          actor_id: admin.id,
          read_at: nil,
          notifiable: evaluation
        )

        expect(recruiter.notifications.last).to have_attributes(
          action: 'start_recruit_evaluation',
          actor_id: admin.id,
          read_at: nil,
          notifiable: evaluation
        )
      end

      it 'responds with 404 error if template not found' do
        recruit = FactoryBot.create(:recruit)

        params = {
          evaluation: {
            public_recruit_id: recruit.public_recruit_id,
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

      it 'responds with error if draft invalid' do
        recruit = FactoryBot.create(:recruit)

        FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)

        template = FactoryBot.create(:template, destination: 'recruits')
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            public_recruit_id: recruit.public_recruit_id,
            template_id: template.id
          }
        }

        allow_any_instance_of(Evaluation).to receive(:valid?).and_return(false)

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 422
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
        recruit = FactoryBot.create(:recruit)

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

      it 'creates proper notifications' do
        recruiter = FactoryBot.create(:user, role: :recruiter)

        recruit = FactoryBot.create(:recruit)
        evaluator = recruit.evaluator

        evaluation = FactoryBot.create(:evaluation_draft_recruit, evaluable: recruit)
        section = FactoryBot.create(:section, sectionable: evaluation)

        params = {
          id: evaluation.id,
          evaluation: {
            state: 'completed',
            sections: [
              {
                id: section.id,
                skills: section.skills
              }
            ]
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { Notification.count }.by(2))

        expect(evaluator.notifications.last).to have_attributes(
          action: 'complete_recruit_evaluation',
          actor_id: admin.id,
          read_at: nil,
          notifiable: evaluation
        )

        expect(recruiter.notifications.last).to have_attributes(
          action: 'complete_recruit_evaluation',
          actor_id: admin.id,
          read_at: nil,
          notifiable: evaluation
        )
      end

      it 'responds with error if invalid section' do
        recruit = FactoryBot.create(:recruit)

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
        recruit = FactoryBot.create(:recruit)

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
