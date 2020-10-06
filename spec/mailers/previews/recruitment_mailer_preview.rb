# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer

class RecruitmentMailerPreview < ActionMailer::Preview
  def custom_email
    user = User.where.not(signature: nil).first || User.first
    email_template = EmailTemplate.first

    email = OpenStruct.new(
      from: user.email,
      to: 'jdoe@example.com',
      subject: 'Recruitment In Progress',
      body: email_template.body
    )

    RecruitmentMailer.with(user: user, email: email).custom_email
  end
end
