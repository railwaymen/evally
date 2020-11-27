# frozen_string_literal: true

module V2
  class EmailsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!

    def form
      presenter = V2::Emails::FormPresenter.new(current_user)

      render json: V2::Emails::FormView.render(presenter), status: :ok
    end

    def create
      email_form.save

      head :no_content
    end

    private

    def authorize!
      authorize %i[v2 email]
    end

    def recruit
      @recruit ||= Recruit.find_by(public_recruit_id: email_params[:public_recruit_id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @recruit

      @recruit
    end

    def email_form
      @email_form ||= V2::Emails::BasicForm.new(recruit, user: current_user, params: email_params)
    end

    def email_params
      params.require(:email).permit(
        :from, :to, :cc, :bcc, :subject, :body, :public_recruit_id, :recruit_document_id
      )
    end
  end
end
