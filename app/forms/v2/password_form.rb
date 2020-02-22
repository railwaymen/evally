# frozen_string_literal: true

module V2
  class PasswordForm
    include ActiveModel::Validations

    validate :new_password_length
    validate :password_confirmation
    validate :user_authentication

    def initialize(user, params:)
      @user = user
      @params = params
    end

    def save
      validate_passwords!

      @user.update(password: @params[:new_password])
    end

    private

    def validate_passwords!
      return if valid?

      raise ErrorResponderService.new(:invalid_record, 422, errors.full_messages)
    end

    def password_confirmation
      return if @params[:new_password] == @params[:password_confirmation]

      errors.add(:password_confirmation, 'does not match')
    end

    def user_authentication
      return if @user.valid_password?(@params[:password])

      errors.add(:password, 'is invalid')
    end

    def new_password_length
      return if @params[:new_password]&.length.to_i.between?(6, 32)

      errors.add(:password, 'length must be between 6 and 32 characters')
    end
  end
end
