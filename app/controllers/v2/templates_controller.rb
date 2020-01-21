# frozen_string_literal: true

module V2
  class TemplatesController < ApplicationController
    before_action :authenticate!

    def index
      templates = Template.order(name: :asc)

      render json: V2::TemplateSerializer.render(templates), status: :ok
    end

    def show
      presenter = V2::TemplatePresenter.new(template)

      render json: V2::Views::TemplateView.render(presenter), status: :ok
    end

    private

    def template
      @template ||= Template.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @template

      @template
    end
  end
end
