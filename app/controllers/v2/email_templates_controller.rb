# frozen_string_literal: true

module V2
  class EmailTemplatesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!

    def index
      email_templates = EmailTemplate.includes(:creator).order(name: :asc)

      render json: V2::EmailTemplates::Serializer.render(email_templates), status: :ok
    end

    def show
      render json: V2::EmailTemplates::Serializer.render(email_template), status: :ok
    end

    def create
      create_form.save

      render(
        json: V2::EmailTemplates::Serializer.render(create_form.email_template),
        status: :created
      )
    end

    def update
      update_form.save

      render(
        json: V2::EmailTemplates::Serializer.render(update_form.email_template),
        status: :ok
      )
    end

    def destroy
      email_template.destroy!

      head :no_content
    end

    private

    def authorize!
      authorize [:v2, EmailTemplate]
    end

    def email_template
      @email_template ||= EmailTemplate.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @email_template

      @email_template
    end

    def create_form
      @create_form ||= V2::EmailTemplates::BasicForm.new(
        current_user.email_templates.build,
        params: email_template_params
      )
    end

    def update_form
      @update_form ||= V2::EmailTemplates::BasicForm.new(
        email_template,
        params: email_template_params
      )
    end

    def email_template_params
      params.require(:email_template).permit(:name, :subject, :body)
    end
  end
end
