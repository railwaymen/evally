require 'rails_helper'

RSpec.describe V1::EvaluationsController, type: :controller do

  describe '#index' do
    let(:user) { create(:user) }

    context 'when unauthorized' do
      it 'is not allowed to list evaluations' do
        sign_out

        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        2.times { create(:evaluation_with_sections, :completed, employee: create(:employee, user: user)) }
      end

      it 'responds succesfully with evaluations list (with sections and employees)' do
        sign_in user

        get :index
        expect_success_api_response_for('evaluations')
      end
    end
  end

  describe '#evaluation' do
    let(:employee) { create(:employee) }
    let(:evaluation) { create(:evaluation_with_sections, state: 'completed', employee: employee) }

    it 'responds succesfully' do
      evaluation

      get :evaluation, params: { id: employee.public_token }
      expect_success_api_response_for('evaluation')
    end

    it 'respond with not found error' do
      get :evaluation, params: { id: 'random_token' }
      expect_error_api_response(404)
    end
  end

  describe '#create' do
    let(:user) { create(:user) }

    let(:employee) { create(:employee, user: user) }
    let(:template) { create(:template_with_sections, user: user) }

    let(:evaluation_params) do
      {
        evaluation: {
          employee_id: employee.id,
          template_id: template.id
        }
      }
    end

    context 'when unauthorized' do
      it 'is not allowed to create evaluation' do
        sign_out

        post :create, params: evaluation_params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully with new draft evaluation' do
        expect do
          post :create, params: evaluation_params
        end.to change(user.evaluations, :count).by(1).and change(Section, :count).by(template.sections.count)

        expect(user.evaluations.last.state).to eq 'draft'
        expect_success_api_response_for('evaluation')
      end

      it 'responds with error', :aggregate_failures do
        aggregate_failures 'when employee does not exist' do
          params = { evaluation: { employee_id: 0, template_id: template.id } }

          expect do
            post :create, params: params
          end.not_to change(user.evaluations, :count)

          expect_error_api_response(404)
        end

        aggregate_failures 'when template does not exist' do
          params = { evaluation: { employee_id: employee.id, template_id: 0 } }

          expect do
            post :create, params: params
          end.not_to change(user.evaluations, :count)

          expect_error_api_response(404)
        end

        aggregate_failures 'when evaluation draft already exists' do
          create(:evaluation_with_sections, state: 'draft', employee: employee)

          expect do
            post :create, params: evaluation_params
          end.not_to change(user.evaluations, :count)

          expect_error_api_response(422)
        end
      end
    end
  end

  describe '#update' do
    let(:user) { create(:user) }

    let(:employee) { create(:employee, user: user) }
    let(:evaluation) { create(:evaluation_with_sections, employee: employee) }

    let(:params) do
      {
        id: evaluation.id,
        evaluation: {
          state: 'draft',
          sections_attributes: [
            {
              id: evaluation.sections.first.id,
              skills: evaluation.sections.first.skills
            }
          ]
        }
      }
    end

    context 'when unauthorized' do
      it 'is not allowed to create evaluation' do
        sign_out

        put :update, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully with updated evaluation' do
        params[:evaluation][:sections_attributes].first[:skills].first['value'] = 'New value'

        expect do
          put :update, params: params
        end.to change{ evaluation.sections.first.skills.first['value'] }.to 'New value'

        expect_success_api_response_for('evaluation')
      end

      it 'responds with error', :aggregate_failures do
        aggregate_failures 'when evaluation does not exist' do
          params = { id: 0, evaluation: { state: 'completed'} }

          expect do
            put :update, params: params
          end.not_to change{ evaluation.reload.state }

          expect_error_api_response(404)
        end

        aggregate_failures 'when invalid params' do
          params = { id: evaluation.id, evaluation: { state: 'invalid' } }

          expect do
            put :update, params: params
          end.not_to change{ evaluation.reload.state }

          expect_error_api_response(422)
        end
      end
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    let(:employee) { create(:employee, user: user) }
    let(:evaluation) { create(:evaluation_with_sections, employee: employee) }

    context 'when unauthorized' do
      it 'is not allowed to destroy evaluation' do
        sign_out

        delete :destroy, params: { id: evaluation.id }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully when destroy evaluation' do
        sections_count = evaluation.sections.count * -1

        expect do
          delete :destroy, params: { id: evaluation.id }
        end.to change{ employee.evaluations.count }.by(-1).and change(Section, :count).by sections_count

        expect(response).to have_http_status 204
      end

      it 'responds with error if evaluation is completed' do
        evaluation.completed!

        expect do
          delete :destroy, params: { id: evaluation.id }
        end.not_to change{ employee.evaluations.count }

        expect_error_api_response(404)
      end
    end
  end
end
