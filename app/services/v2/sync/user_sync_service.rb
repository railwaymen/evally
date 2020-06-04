# frozen_string_literal: true

module V2
  module Sync
    class UserSyncService < BaseSyncService
      def perform
        return unless context.is_a? User

        resp = api_client.post(
          '/v2/users/webhook',
          user: context.attributes.slice(
            'email', 'first_name', 'last_name', 'role', 'status'
          )
        )

        Rails.logger.info(
          "\e[33mUser Sync  |  #{resp.status}  |  #{context.id}\e[0m"
        )
      end
    end
  end
end
