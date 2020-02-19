# frozen_string_literal: true

module V2
  class UsersController < ApplicationController
    before_action :authenticate!
    before_action :authorize!

    def index
      users = User.order(status: :asc, first_name: :asc)

      render json: V2::UserSerializer.render(users), status: :ok
    end

    def update
      update_form.save

      render json: V2::UserSerializer.render(user), status: :ok
    end

    private

    def authorize!
      authorize [:v2, User]
    end

    def user
      @user ||= User.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @user

      @user
    end

    def update_form
      @update_form ||= V2::UserUpdateForm.new(user, params: update_params, admin: current_user)
    end

    def update_params
      params.require(:user).permit(:email, :first_name, :last_name, :role, :status)
    end
  end
end
