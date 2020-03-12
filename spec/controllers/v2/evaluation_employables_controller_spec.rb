# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EvaluationEmployablesController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }
  let(:evaluator) { create(:user, role: 'evaluator') }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty serialized employee evaluations' do
        FactoryBot.create(:evaluation_draft_employee)

        sign_in admin
        get :index

        expect(response).to have_http_status 200
        expect(response.body).to have_json_size 1
      end
    end
  end

  describe '#draft' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :draft, params: { id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with 404 error' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        FactoryBot.create(:section, sectionable: draft)

        sign_in evaluator
        get :draft, params: { id: draft.id }

        expect(response).to have_http_status 404
      end
    end

    context 'when authorized' do
      it 'responds with draft' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        FactoryBot.create(:section, sectionable: draft)

        sign_in admin
        get :draft, params: { id: draft.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql evaluation_employable_schema(draft)
      end

      it 'responds with 404 error' do
        sign_in admin
        get :draft, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#completed' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :completed, params: { id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with 404 error' do
        completed = FactoryBot.create(:evaluation_completed_employee)
        FactoryBot.create(:section, sectionable: completed)

        sign_in evaluator
        get :completed, params: { id: completed.id }

        expect(response).to have_http_status 404
      end
    end

    context 'when authorized' do
      it 'responds with completed' do
        completed = FactoryBot.create(:evaluation_completed_employee)
        FactoryBot.create(:section, sectionable: completed)

        sign_in admin
        get :completed, params: { id: completed.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql evaluation_employable_schema(completed)
      end

      it 'responds with 404 error' do
        sign_in admin
        get :completed, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#form' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        get :form
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with employees and templates' do
        employee = FactoryBot.create(:employee, evaluator: evaluator)
        FactoryBot.create(:employee)

        FactoryBot.create(:template, destination: 'employees')

        sign_in evaluator
        get :form

        expect(response).to have_http_status 200

        expect(response.body).to have_json_size(1).at_path('templates')
        expect(json_response['employees'].map { |el| el['id'] }).to contain_exactly employee.id
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          evaluation: {
            employee_id: 1,
            template_id: 1
          }
        }

        post :create, params: params

        expect(response).to have_http_status 401
      end

      it 'responds with 404 error' do
        employee = FactoryBot.create(:employee)

        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            employee_id: employee.id,
            template_id: template.id
          }
        }

        sign_in evaluator
        post :create, params: params

        expect(response).to have_http_status 404
      end
    end

    context 'when authorized' do
      it 'responds with new draft from template' do
        employee = FactoryBot.create(:employee, evaluator: evaluator)

        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            employee_id: employee.id,
            template_id: template.id
          }
        }

        sign_in evaluator

        expect do
          post :create, params: params
        end.to(change { Evaluation.employable.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql(
          evaluation_employable_schema(employee.evaluations.draft.last)
        )
      end

      it 'responds with draft from previous evaluation' do
        employee = FactoryBot.create(:employee)
        FactoryBot.create(:evaluation_completed_employee, evaluable: employee)

        params = {
          evaluation: {
            employee_id: employee.id,
            use_latest: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Evaluation.employable.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql(
          evaluation_employable_schema(employee.evaluations.draft.last)
        )
      end

      it 'responds with error if no employee' do
        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            employee_id: 1,
            template_id: template.id
          }
        }

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Employee does not exist'
      end

      it 'responds with error if no template' do
        employee = FactoryBot.create(:employee)

        params = {
          evaluation: {
            employee_id: employee.id,
            template_id: 1
          }
        }

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Template does not exist'
      end

      it 'responds with error if no latest evaluation' do
        employee = FactoryBot.create(:employee)

        params = {
          evaluation: {
            employee_id: employee.id,
            use_latest: 1
          }
        }

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 404
        expect(json_response['details'].first).to eq 'Employee was not evaluated yet'
      end

      it 'responds with error is similar draft already exists' do
        employee = FactoryBot.create(:employee)
        FactoryBot.create(:evaluation_draft_employee, evaluable: employee)

        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          evaluation: {
            employee_id: employee.id,
            template_id: template.id
          }
        }

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Evaluable record has already draft evaluation'
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

      it 'responds with 404 error' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        section = FactoryBot.create(:section, sectionable: draft)

        params = {
          id: draft.id,
          evaluation: {
            sections: [
              {
                id: section.id,
                name: 'New section name'
              }
            ]
          }
        }

        sign_in evaluator
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end

    context 'when authorized' do
      it 'responds with updated draft' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        section = FactoryBot.create(:section, sectionable: draft)

        params = {
          id: draft.id,
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
        expect(response.body).to be_json_eql evaluation_employable_schema(draft.reload)
      end

      it 'responds with completed evaluation' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        section = FactoryBot.create(:section, sectionable: draft)

        params = {
          id: draft.id,
          evaluation: {
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

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { Evaluation.employable.completed.count }.by(1))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql evaluation_employable_schema(draft.reload)
      end

      it 'responds with error if invalid section' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        section = FactoryBot.create(:section, sectionable: draft)

        params = {
          id: draft.id,
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

      it 'responds with 404 error' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        FactoryBot.create(:section, sectionable: draft)

        sign_in evaluator
        delete :destroy, params: { id: draft.id }

        expect(response).to have_http_status 404
      end
    end

    context 'when authorized' do
      it 'responds with no content' do
        draft = FactoryBot.create(:evaluation_draft_employee)
        FactoryBot.create(:section, sectionable: draft)

        sign_in admin

        expect do
          delete :destroy, params: { id: draft.id }
        end.to(change { Evaluation.employable.draft.count }.by(-1))

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
