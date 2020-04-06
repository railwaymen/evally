# frozen_string_literal: true

# :nocov:
class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.env.fetch(:core).fetch(:base_mailer)
  layout 'mailer'
end
# :nocov:
