# frozen_string_literal: true

module V2
  class PasswordsController < RailsJwtAuth::PasswordsController
    def create
      unless user.send_reset_password_instructions
        raise ErrorResponderService.new(:invalid_record, 422, user.errors.full_messages)
      end

      head :no_content
    end

    def update
      unless tokenized_user.reset_password(*password_update_params.values)
        raise ErrorResponderService.new(:invalid_record, 422, tokenized_user.errors.full_messages)
      end

      head :no_content
    end

    private

    def user
      @user ||= User.find_by(email: password_create_params.fetch(:email, '').strip.downcase)
      raise ErrorResponderService.new(:record_not_found, 404) unless @user

      @user
    end

    def tokenized_user
      @tokenized_user ||= User.find_by(reset_password_token: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @tokenized_user

      @tokenized_user
    end

    def password_update_params
      params.require(:password).permit(:password, :password_confirmation)
    end
  end
end
