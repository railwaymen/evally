module V1
  class TemplatesController < ApplicationController
    before_action :authenticate!

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

  end
end
