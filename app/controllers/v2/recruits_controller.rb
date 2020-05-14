# frozen_string_literal: true

module V2
  class RecruitsController < ApplicationController
    before_action :authenticate_user!

    def show
      presenter = V2::Recruits::ShowPresenter.new(recruit, current_user)

      render json: V2::Recruits::ShowView.render(presenter), status: :ok
    end

    def skills
      render json: V2::Sections::SkillsQuery.new(target: :recruits).call, status: :ok
    end

    def search
      recruits = V2::Recruits::SearchQuery.call(recruits_scope, params: params)

      render json: V2::Recruits::Serializer.render(recruits, view: :search), status: :ok
    end

    def webhook
      head webhook_form.save ? :no_content : :unprocessable_entity
    end

    private

    def recruits_scope
      V2::RecruitPolicy::Scope.new(current_user, Recruit).resolve
    end

    def recruit
      @recruit ||= recruits_scope.find_by(public_recruit_id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @recruit

      @recruit
    end

    def webhook_form
      @webhook_form ||= V2::Recruits::WebhookForm.new(params: webhook_params, user: current_user)
    end

    def webhook_params
      params.require(:recruit).permit(:public_recruit_id, :evaluator_id)
    end
  end
end
