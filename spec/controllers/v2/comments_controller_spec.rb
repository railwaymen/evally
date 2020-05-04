# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::CommentsController, type: :controller do
  let(:admin) { create(:user, role: 'admin') }

  describe '#create' do
    context 'when access denied' do
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

    context 'when access granted' do
      it 'creates comment for recruit' do
        recruit = FactoryBot.create(:recruit)

        params = {
          recruit_id: recruit.public_recruit_id,
          comment: {
            body: 'Lorem ipsum dolor sit amet ...',
            recruit_document_id: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { recruit.comments.count }.by(1))

        expect(response).to have_http_status 201
        expect(response.body).to be_json_eql comment_schema(recruit.comments.last)
      end

      it 'creates proper notifications' do
        evaluator = FactoryBot.create(:user, role: :evaluator)
        recruit = FactoryBot.create(:recruit, evaluator: evaluator)

        params = {
          recruit_id: recruit.public_recruit_id,
          comment: {
            body: 'Lorem ipsum dolor sit amet ...',
            recruit_document_id: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Notification.count }.by(1))

        expect(evaluator.notifications.last).to have_attributes(
          action: 'add_comment',
          actor_id: admin.id,
          read_at: nil,
          notifiable: recruit.comments.last
        )
      end

      it 'responds with 422 if comment body is blank' do
        recruit = FactoryBot.create(:recruit)

        params = {
          recruit_id: recruit.public_recruit_id,
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

      it 'responds with 404 if no recruit' do
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
    context 'when access denied' do
      it 'responds with 401 error' do
        params = {
          id: 1,
          recruit_id: 1,
          comment: {
            body: 'Lorem ipsum dolor sit amet ...'
          }
        }

        put :update, params: params
        expect(response).to have_http_status 401
      end
    end

    context 'when access granted' do
      it 'responds with updated comment' do
        recruit = FactoryBot.create(:recruit)
        comment = FactoryBot.create(:comment, user: admin, recruit: recruit)

        params = {
          id: comment.id,
          recruit_id: recruit.public_recruit_id,
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
        recruit = FactoryBot.create(:recruit)

        params = {
          id: 1,
          recruit_id: recruit.public_recruit_id,
          comment: {
            body: 'Random comment content ...'
          }
        }

        sign_in admin
        put :update, params: params

        expect(response).to have_http_status 404
      end

      it 'responds with 403 if comment older than 15 minutes' do
        recruit = FactoryBot.create(:recruit)

        comment = FactoryBot.create(
          :comment,
          user: admin,
          recruit: recruit,
          created_at: 16.minutes.ago
        )

        params = {
          id: comment.id,
          recruit_id: recruit.public_recruit_id,
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
        recruit = FactoryBot.create(:recruit)
        comment = FactoryBot.create(:comment, recruit: recruit)

        params = {
          id: comment.id,
          recruit_id: recruit.public_recruit_id,
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
        recruit = FactoryBot.create(:recruit)
        comment = FactoryBot.create(:comment, user: admin, recruit: recruit)

        params = {
          id: comment.id,
          recruit_id: recruit.public_recruit_id,
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
    context 'when access denied' do
      it 'responds with 401 error' do
        delete :destroy, params: { recruit_id: 1, id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when access granted' do
      it 'responds with comment deleted placeholder' do
        recruit = FactoryBot.create(:recruit)
        comment = FactoryBot.create(:comment, user: admin, recruit: recruit)

        sign_in admin

        expect do
          delete :destroy, params: { recruit_id: recruit.public_recruit_id, id: comment.id }

          comment.reload
        end.to(change { comment.discarded_at }.from(nil))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql comment_schema(comment)
      end

      it 'responds with 404 if no comment' do
        recruit = FactoryBot.create(:recruit)

        sign_in admin
        delete :destroy, params: { recruit_id: recruit.public_recruit_id, id: 1 }

        expect(response).to have_http_status 404
      end

      it 'responds with 403 if comment older than 15 minutes' do
        recruit = FactoryBot.create(:recruit)

        comment = FactoryBot.create(
          :comment,
          user: admin,
          created_at: 16.minutes.ago,
          recruit: recruit
        )

        sign_in admin

        expect do
          delete :destroy, params: { recruit_id: recruit.public_recruit_id, id: comment.id }
        end.not_to(change { comment.reload.body })

        expect(response).to have_http_status 403
      end

      it 'responds with 403 if foreign comment' do
        recruit = FactoryBot.create(:recruit)
        comment = FactoryBot.create(:comment, recruit: recruit)

        sign_in admin

        expect do
          delete :destroy, params: { recruit_id: recruit.public_recruit_id, id: comment.id }
        end.not_to(change { comment.reload.body })

        expect(response).to have_http_status 403
      end
    end
  end

  describe '#webhook' do
    context 'when access denied' do
      it 'responds with 401 error' do
        post :webhook, params: { recruit_id: 1, comment: { body: '', created_at: Time.current } }
        expect(response).to have_http_status 401
      end
    end

    context 'when access granted' do
      it 'creates new comment' do
        recruit = FactoryBot.create(:recruit)

        params = {
          recruit_id: recruit.public_recruit_id,
          comment: {
            body: 'Lorem ipsum ...',
            created_at: Time.current,
            recruit_document_id: 1,
            change_id: 1
          }
        }

        sign_in admin

        expect do
          post :webhook, params: params
        end.to(change { recruit.comments.count }.by(1))

        expect(response).to have_http_status 204
      end

      it 'updates existing comment' do
        recruit = FactoryBot.create(:recruit)

        comment = FactoryBot.create(
          :comment,
          created_by: 'bot',
          created_at: 1.minute.ago,
          recruit: recruit,
          change_id: 1
        )

        params = {
          recruit_id: recruit.public_recruit_id,
          comment: {
            body: 'New body',
            created_at: comment.created_at,
            change_id: 1
          }
        }

        sign_in admin

        expect do
          post :webhook, params: params
        end.to(change { comment.reload.body }.to('New body'))

        expect(response).to have_http_status 204
      end

      it 'creates proper notifications' do
        evaluator = FactoryBot.create(:user, role: :evaluator)
        recruit = FactoryBot.create(:recruit, evaluator: evaluator)

        params = {
          recruit_id: recruit.public_recruit_id,
          comment: {
            body: 'Lorem ipsum ...',
            created_at: Time.current,
            recruit_document_id: 1,
            change_id: 1
          }
        }

        sign_in admin

        expect do
          post :create, params: params
        end.to(change { Notification.count }.by(1))

        expect(evaluator.notifications.last).to have_attributes(
          action: 'add_comment',
          actor_id: admin.id,
          read_at: nil,
          notifiable: recruit.comments.last
        )
      end
    end
  end
end
