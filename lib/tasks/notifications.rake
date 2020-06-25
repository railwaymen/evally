namespace :notifications do
  desc 'Tasks for sending notifications'

  task upcoming_evaluations: :environment do
    User.joins(:setting).where(settings: { enable_upcoming_notifications: true }).active.map do |u|
      NotificationMailer.with(user: u).upcoming_evaluations.deliver_now
    end
  end
end
