# frozen_string_literal: true

module V2
  class RecruitmentsController < ApplicationController
    before_action :authenticate_user!

    def index
      presenter = V2::Recruitments::IndexPresenter.new

      render json: V2::Recruitments::IndexView.render(presenter), status: :ok
    end

    def show
      presenter = V2::Recruitments::ShowPresenter.new(recruitment)

      render json: V2::Recruitments::ShowView.render(presenter), status: :ok
    end

    private

    def recruitments_scope
      Recruitment.all
    end

    def recruitment
      @recruitment ||= V2::Recruitments::BasicQuery.call(recruitments_scope)
                                                   .find_by(id: params[:id])

      raise ErrorResponderService.new(:record_not_found, 404) unless @recruitment

      @recruitment
    end
  end
end
