# frozen_string_literal: true

module V2
  class InvitationsController < RailsJwtAuth::InvitationsController
    before_action :authenticate_user!, only: :create
    before_action :authorize!, only: :create

    def create
      create_form.save

      render json: V2::UserSerializer.render(create_form.user), status: :created
    end

    private

    def authorize!
      authorize [:v2, User]
    end

    def create_form
      @create_form ||= V2::UserCreateForm.new(params: invitied_user_params, admin: current_user)
    end

    def invitied_user_params
      params.require(:invitation).permit(:email, :first_name, :last_name, :role)
    end
  end
end
