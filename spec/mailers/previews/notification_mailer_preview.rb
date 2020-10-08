# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer

class NotificationMailerPreview < ActionMailer::Preview
  def upcoming_evaluations
    NotificationMailer.with(user: User.first).upcoming_evaluations
  end

  def comment_mention
    NotificationMailer
      .with(user: User.first, comment: Comment.last, actor: User.last)
      .comment_mention
  end
end
