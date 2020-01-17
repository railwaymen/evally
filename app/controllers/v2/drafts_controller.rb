# frozen_string_literal: true

module V2
  class DraftsController < ApplicationController
    before_action :authenticate!

    def index
      presenter = V2::DraftsPresenter.new

      render json: V2::Views::DraftsView.render(presenter), status: :ok
    end

    def show
      presenter = V2::EvaluationPresenter.new(draft)

      render json: V2::Views::DraftView.render(presenter), status: :ok
    end

    def create
      create_form.save
      presenter = V2::EvaluationPresenter.new(create_form.draft)

      render json: V2::Views::DraftView.render(presenter), status: :created
    end

    def update
      update_form.save
      presenter = V2::EvaluationPresenter.new(update_form.draft)

      render json: V2::Views::DraftView.render(presenter), status: :ok
    end

    def destroy
      ActiveRecord::Base.transaction do
        draft.destroy!

        current_user.activities.create!(
          action: 'destroy',
          activable: draft,
          activable_name: draft.employee.fullname
        )
      end

      head :no_content
    end

    private

    def draft
      @draft ||= Evaluation.draft.includes(:employee).find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @draft

      @draft
    end

    def create_form
      @create_form ||= V2::DraftCreateForm.new(
        create_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::DraftUpdateForm.new(
        draft,
        params: update_params,
        user: current_user
      )
    end

    def create_params
      params.require(:draft).permit(:employee_id, :template_id, :use_latest)
    end

    def update_params
      params.require(:draft).permit(
        :state, :next_evaluation_at, sections: [:id, skills: %i[name value needToImprove]]
      )
    end
  end
end
