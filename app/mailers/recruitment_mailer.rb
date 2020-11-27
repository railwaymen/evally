# frozen_string_literal: true

class RecruitmentMailer < ApplicationMailer
  layout 'recruitment_mailer'

  def custom_email
    user

    mail(
      from: sender_email,
      to: email.to,
      cc: email.cc,
      bcc: email.bcc,
      reply_to: sender_email,
      subject: email.subject
    )
  end

  private

  def sender_email
    email.from.presence || user.email
  end

  def user
    @user ||= params[:user]
  end

  def email
    @email ||= params[:email]
  end
end
