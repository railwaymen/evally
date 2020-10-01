# frozen_string_literal: true

module V2
  class ProfileController < ApplicationController
    before_action :authenticate_user!

    def show
      presenter = V2::Profile::ShowPresenter.new(current_user)

      render json: V2::Profile::ShowView.render(presenter), status: :ok
    end

    def update
      profile_form.save

      render json: V2::Users::Serializer.render(profile_form.user), status: :ok
    end

    def password
      password_form.save

      head :no_content
    end

    private

    def profile_form
      @profile_form ||= V2::Profile::UpdateForm.new(current_user, params: user_params)
    end

    def password_form
      @password_form ||= V2::Profile::PasswordForm.new(current_user, params: password_params)
    end

    def user_params
      params.require(:profile).permit(:first_name, :last_name, :signature)
    end

    def password_params
      params.require(:profile).permit(:password, :new_password, :password_confirmation)
    end
  end
end
