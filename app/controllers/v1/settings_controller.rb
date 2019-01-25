module V1
  class SettingsController < ApplicationController
    before_action :authenticate!

    # # PUT /v1/settings/current
    #
    def update
      current_user.setting.update(setting_params)

      render json: V1::UserSerializer.render(current_user), status: 200
    end

    private

    def setting_params
      params.require(:setting).permit!
    end
  end
end
