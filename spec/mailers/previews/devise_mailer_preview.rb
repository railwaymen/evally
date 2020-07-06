# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer

class DeviseMailerPreview < ActionMailer::Preview
  def invitation_instructions
    Devise::Mailer.invitation_instructions(User.first, 'randomtoken')
  end

  def reset_password_instructions
    Devise::Mailer.reset_password_instructions(User.first, 'randomtoken')
  end
end
