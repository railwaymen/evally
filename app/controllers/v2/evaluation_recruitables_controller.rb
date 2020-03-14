# frozen_string_literal: true

module V2
  class EvaluationRecruitablesController < ApplicationController
    before_action :authenticate_user!

    def show; end

    def create
      create_form.save
      presenter = V2::Evaluations::ShowPresenter.new(create_form.draft)

      render json: V2::Evaluations::RecruitableShowView.render(presenter), status: :created
    end

    def update; end

    def destroy; end

    private

    def create_form
      @create_form ||= V2::Evaluations::RecruitableCreateForm.new(
        create_params,
        user: current_user
      )
    end

    def create_params
      params.require(:evaluation).permit(:recruit_id, :template_id)
    end
  end
end
