module V1
  class ActivitiesController < ApplicationController
    before_action :authenticate!

    # GET /v1/activities
    #
    def index
      activities = current_user.activities.since(params[:from]).to(params[:to]).order(created_at: :desc)

      render json: V1::ActivitySerializer.new(activities).serialized_json, status: 200
    end

    # GET /v1/activities/today
    #
    def today
      date = Time.now.utc
      activities = current_user.activities.where(created_at: date.midnight..date.end_of_day).order(created_at: :desc)

      render json: V1::ActivitySerializer.new(activities).serialized_json, status: 200
    end
  end
end
