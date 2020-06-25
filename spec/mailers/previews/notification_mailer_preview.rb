# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer

class NotificationMailerPreview < ActionMailer::Preview
  def upcoming_evaluations
    NotificationMailer.with(user: User.first).upcoming_evaluations
  end
end
