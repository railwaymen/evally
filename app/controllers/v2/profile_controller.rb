# frozen_string_literal: true

module V2
  class ProfileController < ApplicationController
    before_action :authenticate!

    def show
      presenter = V2::ProfilePresenter.new(current_user)

      render json: V2::Views::ProfileView.render(presenter), status: :ok
    end
  end
end
