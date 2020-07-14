# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmailTemplatesController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }
  let(:recruiter) { create(:user, role: 'recruiter') }
  let(:evaluator) { create(:user, role: 'evaluator') }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error to guest' do
        get :index
        expect(response).to have_http_status 401
      end

      it 'responds with error to evaluator' do
        sign_in evaluator
        get :index

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with empty templates' do
        sign_in recruiter
        get :index

        expect(response).to have_http_status 200
        expect(json_response).to eq []
      end
    end
  end

  describe '#show' do
    context 'when unauthorized' do
      it 'responds with error to guest' do
        get :show, params: { id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with error to evaluator' do
        sign_in evaluator
        get :show, params: { id: 1 }

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with email template' do
        email_template = FactoryBot.create(:email_template)

        sign_in recruiter
        get :show, params: { id: email_template.id }

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql email_template_schema(email_template.reload)
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with error to guest' do
        params = {
          email_template: {
            name: 'New Template'
          }
        }

        post :create, params: params
        expect(response).to have_http_status 401
      end

      it 'responds with error to evaluator' do
        params = {
          email_template: {
            name: 'New Template'
          }
        }

        sign_in evaluator
        post :create, params: params

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with new email template' do
        params = {
          email_template: {
            name: 'New Template',
            subject: 'Recruitment Feedback',
            body: 'Lorem ipsum dolor sit amet...'
          }
        }

        sign_in recruiter

        expect do
          post :create, params: params
        end.to(change { EmailTemplate.count }.by(1))

        email_template = EmailTemplate.last

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql email_template_schema(email_template)
      end

      it 'responds with error if params invalid' do
        params = {
          email_template: {
            name: '',
            subject: 'Recruitment Feedback',
            body: 'Lorem ipsum dolor sit amet...'
          }
        }

        sign_in recruiter

        expect do
          post :create, params: params
        end.not_to(change { EmailTemplate.count })

        expect(response).to have_http_status 422
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with error to guest' do
        params = {
          id: 1,
          email_template: {
            name: 'Updated Name'
          }
        }

        put :update, params: params
        expect(response).to have_http_status 401
      end

      it 'responds with error to evaluator' do
        params = {
          id: 1,
          email_template: {
            name: 'Updated Name'
          }
        }

        sign_in evaluator
        put :update, params: params

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with updated email template' do
        email_template = FactoryBot.create(:email_template)

        params = {
          id: email_template.id,
          email_template: {
            name: 'Updated Name'
          }
        }

        sign_in recruiter

        expect do
          put :update, params: params

          email_template.reload
        end.to(change { email_template.name }.to('Updated Name'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql email_template_schema(email_template)
      end

      it 'responds with error if email template invalid' do
        email_template = FactoryBot.create(:email_template)

        params = {
          id: email_template.id,
          email_template: {
            name: ''
          }
        }

        sign_in recruiter

        expect do
          put :update, params: params
        end.not_to(change { email_template.name })

        expect(response).to have_http_status 422
      end

      it 'responds with error if email template not found' do
        params = {
          id: 1,
          email_template: {
            name: 'Updated Name'
          }
        }

        sign_in recruiter
        put :update, params: params

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#destroy' do
    context 'when unauthorized' do
      it 'responds with error to guest' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status 401
      end

      it 'responds with error to evaluator' do
        sign_in evaluator
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'expects to remove email template' do
        email_template = FactoryBot.create(:email_template)

        sign_in recruiter

        expect do
          delete :destroy, params: { id: email_template.id }
        end.to(change { EmailTemplate.count }.by(-1))

        expect(response).to have_http_status 204
      end

      it 'expects to respond with error if email template not found' do
        sign_in recruiter

        expect do
          delete :destroy, params: { id: 1 }
        end.not_to(change { EmailTemplate.count })

        expect(response).to have_http_status 404
      end
    end
  end
end
