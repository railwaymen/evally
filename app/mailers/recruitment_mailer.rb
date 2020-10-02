# frozen_string_literal: true

class RecruitmentMailer < ApplicationMailer
  layout 'recruitment_mailer'

  def custom_email
    user

    @email_template = EmailTemplate.first

    mail(to: 'szymon.chodzidlo@railwaymen.org', subject: 'Test')
  end

  private

  def user
    @user ||= params[:user]
  end
end
