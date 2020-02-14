# frozen_string_literal: true

module V2
  class ProfileForm
    attr_reader :user

    def initialize(user, params:)
      @user = user

      @user.assign_attributes(params)
    end

    def save
      validate_user!
      @user.save
    end

    private

    def validate_user!
      return if @user.valid?

      raise ErrorResponderService.new(:invalid_record, 422, @user.errors.full_messages)
    end
  end
end
