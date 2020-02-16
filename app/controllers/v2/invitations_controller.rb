# frozen_string_literal: true

module V2
  class InvitationsController < RailsJwtAuth::InvitationsController
    before_action :authenticate!, only: :create

    def create
      create_form.save

      render json: V2::UserSerializer.render(create_form.user), status: :created
    end

    private

    def create_form
      @create_form ||= V2::UserCreateForm.new(params: invitied_user_params)
    end

    def invitied_user_params
      params.require(:invitation).permit(:email, :first_name, :last_name, :role)
    end
  end
end
