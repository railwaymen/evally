# frozen_string_literal: true

module V2
  class InvitationAcceptForm
    include ActiveModel::Validations

    validate :password_length
    validate :password_confirmation

    def initialize(user, params:)
      @user = user
      @params = params
    end

    def save
      validate_passwords!

      @user.assign_attributes(password: @params[:password])
      @user.accept_invitation!
    end

    private

    def validate_passwords!
      return if valid?

      raise ErrorResponderService.new(:invalid_record, 422, errors.full_messages)
    end

    def password_confirmation
      return if @params[:password] == @params[:password_confirmation]

      errors.add(:password_confirmation, 'does not match')
    end

    def password_length
      return if @params[:password]&.length.to_i.between?(6, 32)

      errors.add(:password, 'length must be between 6 and 32 characters')
    end
  end
end
