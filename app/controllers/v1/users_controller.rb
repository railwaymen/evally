module V1
  class UsersController < RailsJwtAuth::RegistrationsController
    before_action :authenticate!, except: :create

    # # GET /v1/users/current
    #
    def show
      render json: V1::UserSerializer.new(current_user).serialized_json, status: 200
    end

    # # POST /v1/users
    #
    def create
      user = V1::UserCreatorService.new(attributes: params[:user]).call

      render json: V1::UserSerializer.new(user).serialized_json, status: 200
    end

  end
end
