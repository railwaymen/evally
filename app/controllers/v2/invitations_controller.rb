# frozen_string_literal: true

module V2
  class InvitationsController < ApplicationController
    before_action :authenticate_user!, only: :create
    before_action :authorize!, only: :create

    def create
      create_form.save

      render json: V2::Users::Serializer.render(create_form.user), status: :created
    end

    def update
      V2::Invitations::AcceptForm.new(tokenized_user, params: invitation_params).save

      head :no_content
    end

    private

    def authorize!
      authorize [:v2, User]
    end

    def create_form
      @create_form ||= V2::Users::CreateForm.new(params: invited_user_params, admin: current_user)
    end

    def tokenized_user
      @tokenized_user ||= User.invitation_not_accepted.active.find_by(invitation_token: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @tokenized_user

      @tokenized_user
    end

    def invited_user_params
      params.require(:invitation).permit(:email, :first_name, :last_name, :role)
    end

    def invitation_params
      params.require(:invitation).permit(:password, :password_confirmation)
    end
  end
end
