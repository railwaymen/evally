# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Sync::UsersJob, type: :job do
  describe '#perform' do
    it 'expects to call user sync service' do
      user = FactoryBot.create(:user, role: :evaluator)
      admin = FactoryBot.create(:user, role: :admin)

      job = described_class.new

      allow_any_instance_of(V2::Sync::UserSyncService).to receive(:perform)
      stub_api_client_service

      job.perform(user.id, admin.id)
    end
  end
end
