# frozen_string_literal: true

module V2
  class EvaluationRecruitablesController < ApplicationController
    before_action :authenticate_user!

    def show
      presenter = V2::Evaluations::ShowPresenter.new(evaluation)

      render json: V2::Evaluations::RecruitableShowView.render(presenter), status: :ok
    end

    def create
      create_form.save
      presenter = V2::Evaluations::ShowPresenter.new(create_form.draft)

      render json: V2::Evaluations::RecruitableShowView.render(presenter), status: :created
    end

    def update
      update_form.save
      presenter = V2::Evaluations::ShowPresenter.new(update_form.draft)

      render json: V2::Evaluations::RecruitableShowView.render(presenter), status: :ok
    end

    def destroy
      draft_evaluation.destroy

      head :no_content
    end

    private

    def evaluations_scope
      policy_scope([:v2, Evaluation]).recruitable.includes(:evaluable)
    end

    def evaluation
      @evaluation ||= evaluations_scope.find_by(evaluable_id: params[:recruit_id], id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @evaluation

      @evaluation
    end

    def draft_evaluation
      @draft_evaluation ||= evaluations_scope.draft.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @draft_evaluation

      @draft_evaluation
    end

    def create_form
      @create_form ||= V2::Evaluations::RecruitableCreateForm.new(
        create_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::Evaluations::RecruitableUpdateForm.new(
        draft_evaluation,
        params: update_params,
        user: current_user
      )
    end

    def create_params
      params.require(:evaluation).permit(:recruit_document_id, :template_id)
    end

    def update_params
      params.require(:evaluation).permit(
        :state, sections: [:id, skills: %i[name value needToImprove]]
      )
    end
  end
end
