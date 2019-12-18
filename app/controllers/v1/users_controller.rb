# frozen_string_literal: true

module V1
  class UsersController < RailsJwtAuth::RegistrationsController
    before_action :authenticate!

    # # GET /v1/users/:_
    #
    def show
      render json: V1::UserSerializer.render(current_user), status: :ok
    end

    # # POST /v1/users :ON_HOLD
    #
    # def create
    #   user = V1::UserCreatorService.new(attributes: params[:user]).call

    #   render json: V1::UserSerializer.render(user), status: :ok
    # end

    # # PUT /v1/users/:_
    #
    def update
      user = V1::UserUpdaterService.new(attributes: params[:user], user: current_user).call

      render json: V1::UserSerializer.render(user), status: :ok
    end

    # # PUT /v1/users/:_/password
    #
    def password
      V1::PasswordUpdaterService.new(attributes: params[:password], user: current_user).call

      render json: {}, status: :ok
    end
  end
end
