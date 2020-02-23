# frozen_string_literal: true

module V2
  class UserCreateForm
    attr_reader :user

    def initialize(params:, admin:)
      @user = User.new
      @admin = admin

      @user.assign_attributes(params.merge(extra_params))
    end

    def save(skip_invitation: false)
      validate_user!

      ActiveRecord::Base.transaction do
        skip_invitation ? @user.save! : @user.invite!

        create_activity!
      end
    end

    private

    def validate_user!
      return if @user.valid?

      raise ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
    end

    def extra_params
      { password: SecureRandom.hex }
    end

    def create_activity!
      @admin.activities.create!(
        action: 'create',
        activable: @user,
        activable_name: @user.fullname
      )
    end
  end
end
