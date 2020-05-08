# frozen_string_literal: true

module V2
  module Users
    class UpdateForm
      attr_reader :user

      def initialize(user, params:, admin:)
        @user = user
        @admin = admin

        @user.assign_attributes(params)
      end

      def save
        validate_user!

        @user.save!

        V2::Sync::UsersJob.perform_later(@user.id, @admin.id)
      end

      private

      def validate_user!
        return if @user.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
      end
    end
  end
end
