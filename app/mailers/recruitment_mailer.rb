# frozen_string_literal: true

class RecruitmentMailer < ApplicationMailer
  def custom_email
    mail(to: 'szymon.chodzidlo@railwaymen.org', subject: 'Test')
  end
end
