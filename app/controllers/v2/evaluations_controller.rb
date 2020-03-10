# frozen_string_literal: true

module V2
  class EvaluationsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!

    def show
      presenter = V2::Evaluations::ShowPresenter.new(evaluation)

      render json: V2::Evaluations::ShowView.render(presenter), status: :ok
    end

    private

    def authorize!
      authorize([:v2, Evaluation])
    end

    def evaluations_scope
      policy_scope([:v2, Evaluation])
    end

    def evaluation
      @evaluation ||= evaluations_scope.completed.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @evaluation

      @evaluation
    end
  end
end
