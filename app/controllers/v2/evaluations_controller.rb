# frozen_string_literal: true

module V2
  class EvaluationsController < ApplicationController
    before_action :authenticate!
    before_action :authorize!

    def show
      presenter = V2::EvaluationPresenter.new(evaluation)

      render json: V2::Views::EvaluationView.render(presenter), status: :ok
    end

    private

    def authorize!
      authorize [:v2, evaluation]
    end

    def evaluation
      @evaluation ||= Evaluation.completed.includes(:employee).find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @evaluation

      @evaluation
    end
  end
end
