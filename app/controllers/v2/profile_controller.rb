# frozen_string_literal: true

module V2
  class ProfileController < ApplicationController
    before_action :authenticate!

    def show
      presenter = V2::ProfilePresenter.new(current_user)

      render json: V2::Views::ProfileView.render(presenter), status: :ok
    end

    def update
      profile_form.save

      render json: V2::UserSerializer.render(profile_form.user), status: :ok
    end

    private

    def profile_form
      @profile_form ||= V2::ProfileForm.new(current_user, params: user_params)
    end

    def user_params
      params.require(:profile).permit(:first_name, :last_name)
    end
  end
end
