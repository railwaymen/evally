# frozen_string_literal: true

module V2
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def show
      presenter = V2::Dashboard::ShowPresenter.new(current_user)

      render json: V2::Dashboard::ShowView.render(presenter), status: :ok
    end
  end
end
