# frozen_string_literal: true

module VueRoutesHelper
  def vue_employee_url(resource)
    "#{host}/app/employees/#{resource&.id || resource}"
  end

  def vue_notifications_settings_url
    "#{host}/app/settings/notifications"
  end

  def host
    Rails.application.config.env.fetch(:core).fetch(:mailer_host)
  end
end
