# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  add_template_helper VueRoutesHelper

  def upcoming_evaluations
    @presenter = V2::Notifications::UpcomingEvaluationsPresenter.new(user)

    mail(to: user.mail_to, subject: @presenter.mail_subject)
  end

  private

  def user
    @user ||= params[:user]
  end
end
