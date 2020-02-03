# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::SettingsController, type: :controller do
  let(:user) { create(:user) }

  describe '#update' do
    context 'when unauthorized' do
      it 'responds with error' do
        params = {
          settings: {
            lang: 'pl'
          }
        }

        sign_out
        put :update, params: params

        expect(response).to have_http_status 401
      end
    end

    context 'when authorized' do
      it 'expects to update user settings' do
        params = {
          settings: {
            default_draft_items: 10,
            default_upcoming_items: 10,
            default_next_evaluation_time: 12,
            lang: 'pl'
          }
        }

        sign_in user
        put :update, params: params

        expect(response).to have_http_status 200
        expect(response.body).to be_json_eql setting_schema(user.setting.reload)
      end
    end
  end
end