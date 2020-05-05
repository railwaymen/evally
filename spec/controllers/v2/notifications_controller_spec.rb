# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::NotificationsController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when unauthorized' do
      it 'responds with error' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with notifications and unread count' do
        FactoryBot.create(:notification, recipient: user, read_at: nil)
        FactoryBot.create(:notification, recipient: user)
        FactoryBot.create(:notification)

        sign_in user
        get :index

        expect(response).to have_http_status 200

        expect(response.body).to have_json_size(2).at_path('notifications')
        expect(json_response['unread_notifications_count']).to eq 1
      end
    end
  end

  describe '#read' do
    context 'when unauthorized' do
      it 'responds with error' do
        put :read, params: { id: 1 }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'responds with read notification' do
        notification = FactoryBot.create(:notification, recipient: user, read_at: nil)

        sign_in user

        expect do
          put :read, params: { id: notification.id }
        end.to(change { notification.reload.read_at }.from(nil))

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql notification_schema(notification).to_json
      end

      it 'responds with not found error' do
        sign_in user
        put :read, params: { id: 1 }

        expect(response).to have_http_status 404
      end
    end
  end

  describe '#read_all' do
    context 'when unauthorized' do
      it 'responds with error' do
        put :read_all, params: { latest_fetch_at: Time.current }
        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'marks all notifications before latest fetch as read' do
        latest_fetch_at = Time.current - 3.minutes

        # Notification before latest fetch
        notification = FactoryBot.create(
          :notification,
          recipient: user,
          read_at: nil,
          created_at: latest_fetch_at - 1.minute
        )

        # Notification after latest fetch
        new_notification = FactoryBot.create(
          :notification,
          recipient: user,
          read_at: nil,
          created_at: latest_fetch_at + 1.minute
        )

        sign_in user

        expect do
          put :read_all, params: { latest_fetch_at: latest_fetch_at }
        end.to(change { notification.reload.read_at }.from(nil))

        expect(new_notification.reload.read_at).to be_nil

        expect(response.body).to have_json_size(1).at_path('notifications')
        expect(json_response['unread_notifications_count']).to eq 0
      end
    end
  end
end
