# frozen_string_literal: true

module V1
  class TemplatesController < ApplicationController
    before_action :authenticate!

    before_action :set_template, only: %i[update destroy]

    # GET /v1/templates
    #
    def index
      templates = Template.includes(:sections).order(name: :asc)

      render json: V1::TemplateSerializer.render(templates), status: :ok
    end

    # POST /v1/templates
    #
    def create
      template = V1::TemplateCreatorService.new(
        attributes: params[:template],
        user: current_user
      ).call

      render json: V1::TemplateSerializer.render(template), status: :ok
    end

    # # PUT /v1/templates/:id
    #
    def update
      template = V1::TemplateUpdaterService.new(
        attributes: params[:template],
        template: @template,
        user: current_user
      ).call

      render json: V1::TemplateSerializer.render(template), status: :ok
    end

    # # DELETE /v1/template/:id
    #
    def destroy
      @template.destroy
      current_user.activities.create(
        action: 'destroy',
        activable: @template,
        activable_name: @template.name
      )

      render json: {}, status: :no_content
    end

    private

    def set_template
      @template = Template.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @template
    end
  end
end
