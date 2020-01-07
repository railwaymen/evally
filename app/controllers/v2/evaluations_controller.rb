# frozen_string_literal: true

module V2
  class EvaluationsController < ApplicationController
    before_action :authenticate!

    def drafts
      drafts = V2::EvaluationsQuery.call(Evaluation.draft).order(updated_at: :desc)

      render json: V2::EvaluationSerializer.render(drafts), status: :ok
    end

    def show
      presenter = V2::EvaluationPresenter.new(evaluation)

      render json: V2::Views::EvaluationView.render(presenter), status: :ok
    end

    def update
      update_form.save
      presenter = V2::EvaluationPresenter.new(update_form.evaluation)

      render json: V2::Views::EvaluationView.render(presenter), status: :ok
    end

    def destroy
      ActiveRecord::Base.transaction do
        evaluation.destroy!

        current_user.activities.create!(
          action: 'destroy',
          activable: evaluation,
          activable_name: evaluation.employee.fullname
        )
      end

      head :no_content
    end

    private

    def evaluation
      @evaluation ||= V2::EvaluationsQuery.call(Evaluation.draft).find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @evaluation

      @evaluation
    end

    def update_form
      @update_form ||= V2::EvaluationUpdateForm.new(
        evaluation,
        params: update_params,
        user: current_user
      )
    end

    def update_params
      params.require(:evaluation).permit(
        :state, :next_evaluation_at, sections: [:id, skills: %i[name value needToImprove]]
      )
    end
  end
end
