# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::TemplatesController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        sign_out

        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with empty templates' do
        sign_in user
        get :index

        expect(response).to have_http_status 200

        expect(response.body).to be_json_eql('[]')
      end
    end
  end

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error' do
        sign_out

        get :show, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with template' do
        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        sign_in user
        get :show, params: { id: template.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql template_schema(template)
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
          template: {
            name: 'Lorem ipsum',
            sections: []
          }
        }

        sign_out
        post :create, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with new template' do
        params = {
          template: {
            name: 'Lorem ipsum',
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

        sign_in user

        expect do
          post :create, params: params
        end.to(change { Template.count }.by(1).and(change { Section.count }.by(1)))

        expect(response).to have_http_status 201
      end

      it 'responds with validation error' do
        params = {
          template: {
            name: '',
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

        sign_in user
        post :create, params: params

        expect(response).to have_http_status 422
        expect(json_response['details'].first).to eq 'Name can\'t be blank'
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          id: 1,
          template: {
            name: 'Lorem ipsum'
          }
        }

        sign_out
        put :update, params: params

        expect(response).to have_http_status 401
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

        sign_in user
        put :update, params: params

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql template_schema(template.reload)
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

        sign_in user

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

        sign_in user

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

        sign_in user
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#destroy' do
    context 'when unauthorized' do
      it 'responds with error' do
        sign_out
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with no content' do
        template = FactoryBot.create(:template)
        FactoryBot.create(:section, sectionable: template)

        sign_in user

        expect do
          delete :destroy, params: { id: template.id }
        end.to(change { Template.count }.by(-1).and(change { Section.count }.by(-1)))

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
