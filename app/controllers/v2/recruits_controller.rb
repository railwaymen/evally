# frozen_string_literal: true

module V2
  class RecruitsController < ApplicationController
    before_action :authenticate_user!

    def show
      presenter = V2::Recruits::ShowPresenter.new(recruit, current_user)

      render json: V2::Recruits::ShowView.render(presenter), status: :ok
    end

    private

    def recruit
      @recruit ||= Recruit.find_by(public_recruit_id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @recruit

      @recruit
    end
  end
end
