# frozen_string_literal: true

module V2
  class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
      presenter = V2::Notifications::IndexPresenter.new(notifications_scope, size: 7)

      render json: V2::Notifications::IndexView.render(presenter), status: :ok
    end

    def read
      notification.update(read_at: Time.current) if notification.read_at.blank?

      render json: V2::Notifications::Serializer.render(notification), status: :ok
    end

    private

    def notifications_scope
      Notification.includes(:notifiable, :actor).where(recipient: current_user)
    end

    def notification
      @notification ||= notifications_scope.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @notification

      @notification
    end
  end
end
