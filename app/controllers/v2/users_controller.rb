# frozen_string_literal: true

module V2
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!

    def index
      render json: V2::Users::Serializer.render(users_scope), status: :ok
    end

    def active
      render json: V2::Users::Serializer.render(users_scope.active), status: :ok
    end

    def update
      update_form.save

      render json: V2::Users::Serializer.render(user), status: :ok
    end

    private

    def authorize!
      authorize [:v2, User]
    end

    def users_scope
      User.order(status: :asc, first_name: :asc)
    end

    def user
      @user ||= User.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @user

      @user
    end

    def update_form
      @update_form ||= V2::Users::UpdateForm.new(user, params: update_params, admin: current_user)
    end

    def update_params
      params.require(:user).permit(:email, :first_name, :last_name, :role, :status)
    end
  end
end
