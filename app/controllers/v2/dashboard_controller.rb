# frozen_string_literal: true

module V2
  class DashboardController < ApplicationController
    before_action :authenticate!

    def show
      presenter = V2::DashboardPresenter.new(current_user)

      render json: V2::Views::DashboardView.render(presenter), status: :ok
    end
  end
end
