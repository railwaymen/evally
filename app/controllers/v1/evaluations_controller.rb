module V1
  class EvaluationsController < ApplicationController
    before_action :authenticate!

    # GET /v1/evaluations
    #
    def index
      evaluations = current_user.evaluations.includes(:employee)

      render json: V1::EvaluationSerializer.new(evaluations).serialized_json, status: 200
    end

    # POST /v1/evaluations
    #
    def create
      evaluation = V1::EvaluationCreatorService.new(attributes: params[:evaluation], user: current_user).call

      render json: V1::EvaluationSerializer.new(evaluation).serialized_json, status: 200
    end
  end
end
