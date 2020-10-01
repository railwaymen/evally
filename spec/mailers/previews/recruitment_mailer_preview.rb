# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer

class RecruitmentMailerPreview < ActionMailer::Preview
  def custom_email
    RecruitmentMailer.custom_email
  end
end
