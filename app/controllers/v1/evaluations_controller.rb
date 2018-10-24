module V1
  class EvaluationsController < ApplicationController
    before_action :authenticate!

    before_action :set_evaluation, only: [:update, :destroy]

    # GET /v1/evaluations
    #
    def index
      evaluations = current_user.evaluations.includes(:employee, :sections)

      render json: V1::EvaluationSerializer.new(evaluations).serialized_json, status: 200
    end

    # POST /v1/evaluations
    #
    def create
      evaluation = V1::EvaluationCreatorService.new(attributes: params[:evaluation], user: current_user).call

      render json: V1::EvaluationSerializer.new(evaluation).serialized_json, status: 200
    end

    # # PUT /v1/evaluations/:id
    #
    def update
      evaluation = V1::EvaluationUpdaterService.new(attributes: params[:evaluation], evaluation: @evaluation).call

      render json: V1::EvaluationSerializer.new(evaluation).serialized_json, status: 200
    end

    # # DELETE /v1/evaluations/:id
    #
    def destroy
      @evaluation.destroy
      render json: {}, status: 204
    end

    private

    def set_evaluation
      @evaluation = current_user.evaluations.draft.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @evaluation
    end
  end
end
