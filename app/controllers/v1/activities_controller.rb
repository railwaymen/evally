# frozen_string_literal: true

module V1
  class ActivitiesController < ApplicationController
    before_action :authenticate!

    # GET /v1/activities
    #
    def index
      activities = Activity.includes(:user)
                           .since(params[:from])
                           .to(params[:to])
                           .order(created_at: :desc)

      render json: V1::ActivitySerializer.render(activities), status: :ok
    end

    # GET /v1/activities/today
    #
    def today
      date = Time.now.utc
      activities = Activity.includes(:user)
                           .where(created_at: date.midnight..date.end_of_day)
                           .order(created_at: :desc)

      render json: V1::ActivitySerializer.render(activities), status: :ok
    end
  end
end
