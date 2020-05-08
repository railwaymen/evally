# frozen_string_literal: true

module V2
  module Users
    class CreateForm
      attr_reader :user

      def initialize(params:, admin:)
        @user = User.new
        @admin = admin

        @user.assign_attributes(params.merge(extra_params))
      end

      def save(skip_invitation: false)
        validate_user!

        skip_invitation ? @user.save! : @user.invite!

        V2::Sync::UsersJob.perform_later(@user.id, @admin.id)
      end

      private

      def validate_user!
        return if @user.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
      end

      def extra_params
        { password: SecureRandom.hex }
      end
    end
  end
end
