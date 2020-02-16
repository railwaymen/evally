# frozen_string_literal: true

module V2
  class UsersController < ApplicationController
    before_action :authenticate!

    def index
      users = User.order(status: :asc, first_name: :asc)

      render json: V2::UserSerializer.render(users), status: :ok
    end

    def create; end

    def update; end
  end
end
