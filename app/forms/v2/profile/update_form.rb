# frozen_string_literal: true

module V2
  module Profile
    class UpdateForm
      attr_reader :user

      def initialize(user, params:)
        @user = user

        @user.assign_attributes(params)
      end

      def save
        validate_user!

        user_sync.perform if @user.save
      end

      private

      def validate_user!
        return if @user.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
      end

      def user_sync
        @user_sync ||= V2::Sync::UserSyncService.new(@user, @user)
      end
    end
  end
end
