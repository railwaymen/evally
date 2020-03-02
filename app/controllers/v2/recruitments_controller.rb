# frozen_string_literal: true

module V2
  class RecruitmentsController < ApplicationController
    before_action :authenticate_user!

    def index
      presenter = V2::Recruitments::IndexPresenter.new

      render json: V2::Recruitments::IndexView.render(presenter), status: :ok
    end
  end
end
