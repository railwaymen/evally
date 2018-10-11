require 'rails_helper'

RSpec.describe V1::TemplatesController, type: :controller do

  describe '#index' do
    let(:user) { create(:user) }

    context 'when unauthorized' do
      it 'is not allowed to list templates' do
        sign_out

        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        2.times { create(:template_with_sections, user: user) }
      end

      it 'responds succesfully with templates list (with sections)' do
        sign_in user

        get :index
        expect_success_api_response_for('templates')
      end
    end
  end

  describe '#create' do
    let(:user) { create(:user) }

    let(:template_params) do
      {
        name: 'Rspec Template',
        state: 'draft',
        sections_attributes: [
          {
            name: 'Section 1',
            group: 'bool',
            width: 'half',
            position: 0,
            skills: [
              { name: 'Skill 1', value: false },
              { name: 'Skill 2', value: true }
            ]
          },
          {
            name: 'Section 2',
            group: 'rating',
            width: 'half',
            position: 1,
            skills: [
              { name: 'Skill 3', value: 0 },
              { name: 'Skill 4', value: 5 }
            ]
          }
        ]
      }
    end

    let(:invalid_params) do
      {
        name: '',
        state: 'draft',
        sections_attributes: []
      }
    end

    context 'when unauthorized' do
      it 'is not allowed to create template' do
        sign_out

        post :create, params: { template: template_params }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds succesfully with new template (with sections)' do
        expect do
          post :create, params: { template: template_params }
        end.to change(user.templates, :count).by(1).and change(Section, :count).by(2)

        expect(user.templates.last.sections.count).to eq 2
        expect_success_api_response_for('template')
      end

      it 'responds with error when invalid params' do
        expect do
          post :create, params: { template: invalid_params }
        end.not_to change(user.templates, :count)

        expect_error_api_response(422)
      end

      it 'responds succesfully with new template', :aggregate_failures do
        aggregate_failures 'and reject invalid section' do
          template_params[:sections_attributes][2] = attributes_for(:section, name: '')
          expect(template_params[:sections_attributes].count).to eq 3

          expect do
            post :create, params: { template: template_params }
          end.to change(user.templates, :count).by(1).and change(Section, :count).by(2)

          expect_success_api_response_for('template')
        end

        aggregate_failures 'and reject section where skill has not name key' do
          template_params[:sections_attributes][2] = attributes_for(:section,skills: [{ value: 0 }])
          expect(template_params[:sections_attributes].count).to eq 3

          expect do
            post :create, params: { template: template_params }
          end.to change(user.templates, :count).by(1).and change(Section, :count).by(2)

          expect_success_api_response_for('template')
        end

        aggregate_failures 'and reject section where skill has not value key' do
          template_params[:sections_attributes][2] = attributes_for(:section,skills: [{ name: 'Lorem ...' }])
          expect(template_params[:sections_attributes].count).to eq 3

          expect do
            post :create, params: { template: template_params }
          end.to change(user.templates, :count).by(1).and change(Section, :count).by(2)

          expect_success_api_response_for('template')
        end
      end
    end
  end

  describe '#destroy' do
    let(:template) { create(:template_with_sections) }
    let(:user) { template.user }

    context 'when unauthorized' do
      it 'is not allowed to destroy template' do
        sign_out
  
        delete :destroy, params: { id: template.id }
        expect(response).to have_http_status 401
      end
    end
    
    context 'when authorized' do
      before(:each) do
        sign_in user
      end

      it 'responds with error when template not found' do
        expect do
          delete :destroy, params: { id: 0 }
        end.not_to change{ user.templates.count }

        expect_error_api_response(404)
      end

      it 'deletes template and rsponds with 204' do
        expect do
          delete :destroy, params: { id: template.id }
        end.to change{ user.templates.count }.by(-1).and change(Section, :count).by -3

        expect(response).to have_http_status 204
      end
    end
  end
end
