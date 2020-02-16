# frozen_string_literal: true

module V2
  class UserUpdateForm
    attr_reader :user

    def initialize(user, params:, admin:)
      @user = user
      @admin = admin

      @user.assign_attributes(params)
    end

    def save
      validate_user!

      ActiveRecord::Base.transaction do
        @user.save!

        create_activity!
      end
    end

    private

    def validate_user!
      return if @user.valid?

      raise ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
    end

    def create_activity!
      @admin.activities.create!(
        action: 'update',
        activable: @user,
        activable_name: @user.fullname
      )
    end
  end
end
