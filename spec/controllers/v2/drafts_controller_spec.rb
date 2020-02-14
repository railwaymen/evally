# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::DraftsController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty drafts, employees and templates' do
        sign_in user
        get :index

        expect(response).to have_http_status 200

        expect(response.body).to have_json_path('drafts')
        expect(response.body).to have_json_path('employees')
        expect(response.body).to have_json_path('templates')
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
      it 'responds with draft' do
        draft = FactoryBot.create(:evaluation, :draft)
        FactoryBot.create(:section, sectionable: draft)

        sign_in user
        get :show, params: { id: draft.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql draft_schema(draft)
      end

      it 'responds with 404 error' do
        sign_in user
        get :show, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          draft: {
            employee_id: 1,
            template_id: 1
          }
        }

        post :create, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with new draft from template' do
        employee = FactoryBot.create(:employee)

        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          draft: {
            employee_id: employee.id,
            template_id: template.id
          }
        }

        sign_in user

        expect do
          post :create, params: params
        end.to(change { Evaluation.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql draft_schema(Evaluation.draft.last)
      end

      it 'responds with draft from previous evaluation' do
        employee = FactoryBot.create(:employee)
        FactoryBot.create(:evaluation, :completed, employee: employee)

        params = {
          draft: {
            employee_id: employee.id,
            use_latest: 1
          }
        }

        sign_in user

        expect do
          post :create, params: params
        end.to(change { Evaluation.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql draft_schema(Evaluation.draft.last)
      end

      it 'responds with error if no employee' do
        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          draft: {
            employee_id: 1,
            template_id: template.id
          }
        }

        sign_in user
        post :create, params: params

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Employee does not exist'
      end

      it 'responds with error if no template' do
        employee = FactoryBot.create(:employee)

        params = {
          draft: {
            employee_id: employee.id,
            template_id: 1
          }
        }

        sign_in user
        post :create, params: params

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Template does not exist'
      end

      it 'responds with error if no latest evaluation' do
        employee = FactoryBot.create(:employee)

        params = {
          draft: {
            employee_id: employee.id,
            use_latest: 1
          }
        }

        sign_in user
        post :create, params: params

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Employee was not evaluated yet'
      end

      it 'responds with error is similar draft already exists' do
        employee = FactoryBot.create(:employee)
        FactoryBot.create(:evaluation, :draft, employee: employee)

        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          draft: {
            employee_id: employee.id,
            template_id: template.id
          }
        }

        sign_in user
        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Employee draft evaluation already exists'
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          id: 1,
          draft: {
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
      it 'responds with updated draft' do
        draft = FactoryBot.create(:evaluation, :draft)
        section = FactoryBot.create(:section, sectionable: draft)

        params = {
          id: draft.id,
          draft: {
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

        sign_in user

        expect do
          put :update, params: params
        end.to(change { section.reload.skills.first['value'] }.to('New value'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql draft_schema(draft.reload)
      end

      it 'responds with completed evaluation' do
        draft = FactoryBot.create(:evaluation, :draft)
        section = FactoryBot.create(:section, sectionable: draft)

        params = {
          id: draft.id,
          draft: {
            state: 'completed',
            next_evaluation_on: 6.months.from_now.strftime('%Y-%M'),
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

        sign_in user

        expect do
          put :update, params: params
        end.to(change { Evaluation.completed.count }.by(1))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql draft_schema(draft.reload)
      end

      it 'responds with error if invalid section' do
        draft = FactoryBot.create(:evaluation, :draft)
        section = FactoryBot.create(:section, sectionable: draft)

        params = {
          id: draft.id,
          draft: {
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

        sign_in user
        put :update, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Sections skills must have name and value'
      end
    end
  end

  describe '#destroy' do
    context 'when unauthorized' do
      it 'responds with error' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with no content' do
        draft = FactoryBot.create(:evaluation, :draft)
        FactoryBot.create(:section, sectionable: draft)

        sign_in user

        expect do
          delete :destroy, params: { id: draft.id }
        end.to(change { Evaluation.draft.count }.by(-1))

        expect(response).to have_http_status 204
      end

      it 'responds with 404 error' do
        sign_in user
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end
end
