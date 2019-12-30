# frozen_string_literal: true

module V2
  class EvaluationsController < ApplicationController
    before_action :authenticate!

    def drafts
      drafts = V2::EvaluationsQuery.call(Evaluation.draft).order(updated_at: :desc)

      render json: V2::EvaluationSerializer.render(drafts), status: :ok
    end

    def show
      evaluation = V2::EvaluationsQuery.call.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless evaluation

      presenter = V2::EvaluationPresenter.new(evaluation)

      render json: V2::Views::EvaluationView.render(presenter), status: :ok
    end
  end
end
