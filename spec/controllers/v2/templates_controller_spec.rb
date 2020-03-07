# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::TemplatesController, type: :controller do
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
      it 'responds with empty templates' do
        sign_in admin
        get :index

        expect(response).to have_http_status 200
        expect(json_response.keys).to contain_exactly(
          'templates',
          'destinations'
        )
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
      it 'responds with template' do
        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        sign_in admin
        get :show, params: { id: template.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql template_schema(template)
      end

      it 'responds with 404 error' do
        sign_in admin
        get :show, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          template: {
            name: 'Lorem ipsum',
            destination: 'employees',
            sections: []
          }
        }

        post :create, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with new template' do
        params = {
          template: {
            name: 'Lorem ipsum',
            destination: 'employees',
            sections: [
              {
                name: 'Section A',
                width: 'full',
                position: 0,
                group: 'rating',
                skills: [
                  {
                    name: 'Skill 1',
                    value: 0,
                    needToImprove: false
                  }
                ]
              }
            ]
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Template.count }.by(1).and(change { Section.count }.by(1)))

        expect(response).to have_http_status 201
      end

      it 'responds with validation error' do
        params = {
          template: {
            name: '',
            destination: 'employees',
            sections: [
              {
                name: 'Section A',
                width: 'full',
                position: 0,
                group: 'rating',
                skills: [
                  {
                    name: 'Skill 1',
                    value: 0,
                    needToImprove: false
                  }
                ]
              }
            ]
          }
        }

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Name can\'t be blank'
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          id: 1,
          template: {
            name: 'Lorem ipsum'
          }
        }

        put :update, params: params

        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        template = FactoryBot.create(:template)

        params = {
          id: template.id,
          template: {
            name: 'Lorem ipsum'
          }
        }

        sign_in evaluator
        put :update, params: params

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with updated template' do
        template = FactoryBot.create(:template)
        section = FactoryBot.create(:section, sectionable: template)

        params = {
          id: template.id,
          template: {
            name: 'New template name',
            sections: [
              {
                id: section.id,
                name: 'New section name'
              }
            ]
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql template_schema(template.reload)
      end

      it 'can update own template' do
        template = FactoryBot.create(:template, creator: evaluator)
        section = FactoryBot.create(:section, sectionable: template)

        params = {
          id: template.id,
          template: {
            name: 'New template name',
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

        expect(response).to have_http_status 200
      end

      it 'responds with new section' do
        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        params = {
          id: template.id,
          template: {
            name: 'New template name',
            sections: [
              {
                name: 'Section A',
                width: 'full',
                position: 1,
                group: 'rating'
              }
            ]
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { template.sections.count }.by(1))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql template_schema(template.reload)
      end

      it 'responds without removed section' do
        template = FactoryBot.create(:template)
        section = FactoryBot.create(:section, sectionable: template)

        params = {
          id: template.id,
          template: {
            name: 'New template name',
            sections: [
              {
                id: section.id,
                _destroy: 1
              }
            ]
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.to(change { template.sections.count }.by(-1))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql template_schema(template.reload)
      end

      it 'responds with not found error' do
        params = {
          id: 1,
          template: {
            name: 'New template name',
            sections: [
              {
                id: 1,
                name: 'New section name'
              }
            ]
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#destroy' do
    context 'when unauthorized' do
      it 'responds with error' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with 403 error' do
        template = FactoryBot.create(:template)

        sign_in evaluator
        delete :destroy, params: { id: template.id }

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with no content' do
        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        sign_in admin

        expect do
          delete :destroy, params: { id: template.id }
        end.to(change { Template.count }.by(-1).and(change { Section.count }.by(-1)))

        expect(response).to have_http_status 204
      end

      it 'can destroy own template' do
        template = FactoryBot.create(:template, creator: evaluator)

        sign_in evaluator

        expect do
          delete :destroy, params: { id: template.id }
        end.to(change { Template.count }.by(-1))

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
