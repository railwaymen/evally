# frozen_string_literal: true

module V2
  class DraftsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!

    def index
      presenter = V2::Drafts::IndexPresenter.new(current_user)

      render json: V2::Views::DraftsView.render(presenter), status: :ok
    end

    def show
      presenter = V2::Evaluations::ShowPresenter.new(draft)

      render json: V2::Views::DraftView.render(presenter), status: :ok
    end

    def create
      create_form.save
      presenter = V2::Evaluations::ShowPresenter.new(create_form.draft)

      render json: V2::Views::DraftView.render(presenter), status: :created
    end

    def update
      update_form.save
      presenter = V2::Evaluations::ShowPresenter.new(update_form.draft)

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

    def authorize!
      authorize([:v2, Evaluation])
    end

    def draft
      @draft ||= policy_scope([:v2, Evaluation]).draft.includes(:employee).find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @draft

      @draft
    end

    def create_form
      @create_form ||= V2::Drafts::CreateForm.new(
        create_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::Drafts::UpdateForm.new(
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
        :state, :next_evaluation_on, sections: [:id, skills: %i[name value needToImprove]]
      )
    end
  end
end
