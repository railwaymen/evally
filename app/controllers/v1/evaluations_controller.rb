module V1
  class EvaluationsController < ApplicationController
    before_action :authenticate!

    # POST /v1/evaluations
    #
    def create
      evaluation = V1::EvaluationCreatorService.new(attributes: params[:evaluation], user: current_user).call

      render json: V1::EvaluationSerializer.new(evaluation).serialized_json, status: 200
    end
  end
end
