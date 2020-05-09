# frozen_string_literal: true

module V2
  module Sync
    class UsersJob < ApplicationJob
      def perform(user_id, current_user_id)
        user = User.find_by(id: user_id)
        current_user = User.find_by(id: current_user_id)

        V2::Sync::UserSyncService.new(user, current_user).perform
      end
    end
  end
end
