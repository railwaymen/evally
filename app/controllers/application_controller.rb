# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RailsJwtAuth::AuthenticableHelper
  include Pundit

  protect_from_forgery with: :exception, unless: lambda {
    Rails.env.production? || request.format.json?
  }

  rescue_from ErrorResponderService, with: :render_error_response
  rescue_from RailsJwtAuth::NotAuthorized, with: :unauthorized_response
  rescue_from Pundit::NotAuthorizedError, with: :forbidden_response

  before_action :set_locale

  private

  def render_error_response(error)
    render json: V2::ErrorSerializer.render(error), status: error.status
  end

  def unauthorized_response
    head :unauthorized
  end

  def forbidden_response
    head :forbidden
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
