class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { Rails.env.production? || request.format.json? }
  rescue_from V1::ErrorResponderService, with: :render_error_response

  include RailsJwtAuth::WardenHelper

  before_action :set_locale

  private

  def render_error_response(error)
    render json: V1::ErrorSerializer.render(error), status: error.status
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
