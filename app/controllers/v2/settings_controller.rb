# frozen_string_literal: true

module V2
  class SettingsController < ApplicationController
    before_action :authenticate_user!

    def update
      setting_form.save

      render json: V2::Settings::Serializer.render(setting_form.setting), status: :ok
    end

    private

    def setting_form
      @setting_form ||= V2::Settings::UpdateForm.new(current_user.setting, params: setting_params)
    end

    def setting_params
      params.require(:setting).permit(
        :default_draft_items, :default_upcoming_items, :default_next_evaluation_time, :lang
      )
    end
  end
end
