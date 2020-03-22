# frozen_string_literal: true

module V2
  class SessionController < ApplicationController
    def create
      unless user.present? && user.valid_password?(session_params[:password])
        raise ErrorResponderService.new(:unauthorized, 401)
      end

      render json: { jwt: JwtService.encode(user) }, status: :created
    end

    private

    def user
      @user ||= User.active.find_by(email: session_params.fetch(:email, '').strip)
    end

    def session_params
      params.require(:session).permit(:email, :password)
    end
  end
end
