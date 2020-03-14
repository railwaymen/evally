# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EvaluationRecruitablesController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

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
end
