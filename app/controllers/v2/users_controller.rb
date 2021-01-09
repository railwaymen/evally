# frozen_string_literal: true

module V2
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_collection!

    def index
      presenter = V2::Users::IndexPresenter.new(User.all, params: table_params)

      render json: V2::Users::IndexView.render(presenter), status: :ok
    end

    def active
      render json: V2::Users::Serializer.render(User.active.order(first_name: :asc)), status: :ok
    end

    def update
      update_form.save

      render json: V2::Users::Serializer.render(user), status: :ok
    end

    private

    def authorize_collection!
      authorize [:v2, User]
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
      params.require(:user).permit(:first_name, :last_name, :role, :status)
    end

    def table_params
      params.permit(:page, :per_page, :sort_by, :sort_dir, :search)
    end
  end
end
