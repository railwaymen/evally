module V1
  class ActivitiesController < ApplicationController
    before_action :authenticate!

    # GET /v1/activities/
    #
    def index
      date = Date.parse(params[:date])
      activities = current_user.activities.where(created_at: date.midnight..date.end_of_day).order(created_at: :desc)

      render json: V1::ActivitySerializer.new(activities).serialized_json, status: 200
    end
  end
end
