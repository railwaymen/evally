class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  rescue_from V1::ErrorResponderService, with: :render_error_response

  private

  def render_error_response(error)
    render json: V1::ErrorSerializer.new(error).serialized_json, status: error.status
  end

end
