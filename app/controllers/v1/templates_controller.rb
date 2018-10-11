module V1
  class TemplatesController < ApplicationController
    before_action :authenticate!

    before_action :set_template, only: [:destroy]

    # GET /v1/templates
    #
    def index
      templates = current_user.templates.includes(:sections).order(name: :asc)

      render json: V1::TemplateSerializer.new(templates).serialized_json, status: 200
    end

    # POST /v1/templates
    #
    def create
      template = V1::TemplateCreatorService.new(attributes: params[:template], user: current_user).call

      render json: V1::TemplateSerializer.new(template).serialized_json, status: 200
    end

    # # DELETE /v1/template/:id
    #
    def destroy
      @template.destroy
      render json: {}, status: 204
    end

    private

    def set_template
      @template = current_user.templates.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @template
    end
  end
end
