module V1
  class TemplatesController < ApplicationController
    before_action :authenticate!

    # GET /v1/templates
    #
    def index
      templates = current_user.templates.includes(:sections).order(name: :asc)

      render json: V1::TemplateSerializer.new(templates).serialized_json, status: 200
    end
  end
end
