module V1
  class EvaluationsController < ApplicationController
    before_action :authenticate!, except: :evaluation

    before_action :set_evaluation, only: [:update, :destroy]

    # GET /v1/evaluations
    #
    def index
      evaluations = Evaluation.includes(:employee, :sections).by_state(params[:state]).order("employees.next_evaluation_at ASC, completed_at DESC")

      render json: V1::EvaluationSerializer.render(evaluations), status: 200
    end

    # GET /v1/employees/:id/evaluation
    #
    def evaluation
      set_employee_by_token

      evaluation = @employee.evaluations.includes(:employee, :sections).completed.order(completed_at: :asc).last
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless evaluation

      render json: V1::EvaluationSerializer.render(evaluation), status: 200
    end

    # POST /v1/evaluations
    #
    def create
      evaluation = V1::EvaluationCreatorService.new(attributes: params[:evaluation], user: current_user).call

      render json: V1::EvaluationSerializer.render(evaluation), status: 200
    end

    # # PUT /v1/evaluations/:id
    #
    def update
      evaluation = V1::EvaluationUpdaterService.new(attributes: params[:evaluation], evaluation: @evaluation, user: current_user).call

      render json: V1::EvaluationSerializer.render(evaluation), status: 200
    end

    # # DELETE /v1/evaluations/:id
    #
    def destroy
      # only draft evaluations can be destroyed directly

      @evaluation.destroy
      current_user.activities.create(action: 'destroy', activable: @evaluation, activable_name: @evaluation.employee.fullname)

      render json: {}, status: 204
    end

    private

    def set_evaluation
      @evaluation = Evaluation.draft.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @evaluation
    end

    def set_employee_by_token
      @employee = Employee.find_by(public_token: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @employee

      # ON HOLD
      # setting = Setting.find_by(user_id: @employee.user_id)
      # raise V1::ErrorResponderService.new(:record_not_found, 404) unless setting&.public_view_enabled?
    end
  end
end
