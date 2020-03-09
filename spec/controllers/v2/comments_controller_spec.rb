# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::CommentsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

  describe '#create' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          recruit_id: 1,
          comment: {
            body: 'Lorem ipsum dolor sit amet ...'
          }
        }

        post :create, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'creates comment for recruit' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        params = {
          recruit_id: recruit.human_resources_id,
          comment: {
            body: 'Lorem ipsum dolor sit amet ...'
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { recruit.comments.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql comment_schema(recruit.comments.last)
      end

      it 'responds with 422 if comment body is blank' do
        recruit_document = FactoryBot.create(:recruit_document)
        recruit = recruit_document.recruit

        params = {
          recruit_id: recruit.human_resources_id,
          comment: {
            body: ''
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.not_to(change { recruit.comments.count })

        expect(response).to have_http_status 422
      end

      it 'responds with 404 ifn no recruit' do
        params = {
          recruit_id: 1,
          comment: {
            body: 'Lorem ipsum dolor sit amet ...'
          }
        }

        sign_in admin
        post :create, params: params

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with 401 error' do
        params = {
          id: 1,
          comment: {
            body: 'Lorem ipsum dolor sit amet ...'
          }
        }

        put :update, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with updated comment' do
        recruit_document = FactoryBot.create(:recruit_document)
        comment = FactoryBot.create(:comment, user: admin, recruit: recruit_document.recruit)

        params = {
          id: comment.id,
          comment: {
            body: 'Random comment content ...'
          }
        }

        sign_in admin

        expect do
          put :update, params: params

          comment.reload
        end.to(change { comment.body }.to('Random comment content ...'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql comment_schema(comment)
      end

      it 'responds with 404 if no comment' do
        params = {
          id: 1,
          comment: {
            body: 'Random comment content ...'
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 404
      end

      it 'responds with 403 if comment older than 15 minutes' do
        recruit_document = FactoryBot.create(:recruit_document)
        comment = FactoryBot.create(
          :comment,
          user: admin,
          recruit: recruit_document.recruit,
          created_at: 16.minutes.ago
        )

        params = {
          id: comment.id,
          comment: {
            body: 'Random comment content ...'
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.not_to(change { comment.reload.body })

        expect(response).to have_http_status 403
      end

      it 'responds with 403 if foreign comment' do
        recruit_document = FactoryBot.create(:recruit_document)
        comment = FactoryBot.create(:comment, recruit: recruit_document.recruit)

        params = {
          id: comment.id,
          comment: {
            body: 'Random comment content ...'
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.not_to(change { comment.reload.body })

        expect(response).to have_http_status 403
      end

      it 'responds with 422 if comment body is blank' do
        recruit_document = FactoryBot.create(:recruit_document)
        comment = FactoryBot.create(:comment, user: admin, recruit: recruit_document.recruit)

        params = {
          id: comment.id,
          comment: {
            body: ''
          }
        }

        sign_in admin

        expect do
          put :update, params: params
        end.not_to(change { comment.reload.body })

        expect(response).to have_http_status 422
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
      it 'responds with comment deleted placeholder' do
        recruit_document = FactoryBot.create(:recruit_document)
        comment = FactoryBot.create(:comment, user: admin, recruit: recruit_document.recruit)

        sign_in admin

        expect do
          delete :destroy, params: { id: comment.id }

          comment.reload
        end.to(change { comment.body }.to('Comment has been deleted'))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql comment_schema(comment)
      end

      it 'responds with 404 if no comment' do
        sign_in admin
        delete :destroy, params: { id: 1 }

        expect(response).to have_http_status 404
      end

      it 'responds with 403 if comment older than 15 minutes' do
        recruit_document = FactoryBot.create(:recruit_document)
        comment = FactoryBot.create(
          :comment,
          user: admin,
          created_at: 16.minutes.ago,
          recruit: recruit_document.recruit
        )

        sign_in admin

        expect do
          delete :destroy, params: { id: comment.id }
        end.not_to(change { comment.reload.body })

        expect(response).to have_http_status 403
      end

      it 'responds with 403 if foreign comment' do
        recruit_document = FactoryBot.create(:recruit_document)
        comment = FactoryBot.create(:comment, recruit: recruit_document.recruit)

        sign_in admin

        expect do
          delete :destroy, params: { id: comment.id }
        end.not_to(change { comment.reload.body })

        expect(response).to have_http_status 403
      end
    end
  end
end
