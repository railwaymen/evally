module V1
  class UsersController < RailsJwtAuth::RegistrationsController

    # # POST /v1/user
    #
    def create
      user = V1::UserCreatorService.new(attributes: params[:user]).call

      render json: V1::UserSerializer.new(user).serialized_json, status: 200
    end

  end
end
