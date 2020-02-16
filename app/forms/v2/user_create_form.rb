# frozen_string_literal: true

module V2
  class UserCreateForm
    attr_reader :user

    def initialize(params:)
      @user = User.new

      @user.assign_attributes(params.merge(extra_params))
    end

    def save(send_invitation: true)
      validate_user!

      send_invitation ? @user.invite! : @user.save!
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
