# frozen_string_literal: true

module V2
  class EmailsController < ApplicationController
    before_action :authenticate_user!

    def form
      presenter = V2::Emails::FormPresenter.new(current_user)

      render json: V2::Emails::FormView.render(presenter), status: :ok
    end
  end
end
