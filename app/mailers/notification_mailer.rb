# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  add_template_helper VueRoutesHelper

  def upcoming_evaluations
    @presenter = V2::Notifications::UpcomingEvaluationsPresenter.new(params[:user])

    mail(to: params[:user].mail_to, subject: @presenter.mail_subject)
  end

  def comment_mention
    mail(
      to: params[:user].mail_to,
      subject: "#{params[:actor].first_name} has mentioned you in a comment"
    )
  end
end
