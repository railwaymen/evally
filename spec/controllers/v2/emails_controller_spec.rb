# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::EmailsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }
  let(:evaluator) { create(:user, role: 'evaluator') }

  describe '#form' do
    context 'when unauthorized' do
      it 'responds with error to guest' do
        get :form
        expect(response).to have_http_status 401
      end

      it 'responds with forbidden error' do
        sign_in evaluator
        get :form

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'responds with form data' do
        sign_in admin
        get :form

        expect(response).to have_http_status 200
        expect(json_response.keys).to contain_exactly(
          'email_templates', 'user', 'sender_emails'
        )
      end
    end
  end

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          email: {
            from: 'from@example.com',
            to: 'to@example.com',
            subject: 'Sample Subject',
            body: 'Dear Mr. Bean, ...',
            public_recruit_id: 1,
            recruit_document_id: 1
          }
        }

        post :create, params: params
        expect(response).to have_http_status 401
      end

      it 'responds with forbidden error' do
        params = {
          email: {
            from: 'from@example.com',
            to: 'to@example.com',
            subject: 'Sample Subject',
            body: 'Dear Mr. Bean, ...',
            public_recruit_id: 1,
            recruit_document_id: 1
          }
        }

        sign_in evaluator
        post :create, params: params

        expect(response).to have_http_status 403
      end
    end

    context 'when authorized' do
      it 'expects to send an email' do
        recruit = FactoryBot.create(:recruit)

        params = {
          email: {
            from: 'from@example.com',
            to: 'to@example.com',
            subject: 'Sample Subject',
            body: 'Dear Mr. Bean, ...',
            public_recruit_id: recruit.public_recruit_id,
            recruit_document_id: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { ActionMailer::Base.deliveries.size }.by(1))

        expect(response).to have_http_status 204
      end

      it 'expects to save email as a comment' do
        recruit = FactoryBot.create(:recruit)

        params = {
          email: {
            from: 'from@example.com',
            to: 'to@example.com',
            subject: 'Sample Subject',
            body: 'Dear Mr. Bean, ...',
            public_recruit_id: recruit.public_recruit_id,
            recruit_document_id: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { recruit.comments.count }.by(1))

        expect(recruit.comments.last).to have_attributes(
          body: params.dig(:email, :body),
          user_id: admin.id,
          recruit_id: recruit.id,
          created_by: 'mailer'
        )
      end

      it 'expects to respond with validation error in case of invalid data' do
        recruit = FactoryBot.create(:recruit)

        params = {
          email: {
            from: '',
            to: 'to@example.com',
            subject: 'Sample Subject',
            body: 'Dear Mr. Bean, ...',
            public_recruit_id: recruit.public_recruit_id,
            recruit_document_id: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.not_to(change { ActionMailer::Base.deliveries.size })

        expect(response).to have_http_status 422
      end
    end
  end
end
