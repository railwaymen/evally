# frozen_string_literal: true

module V2
  class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
      presenter = V2::Notifications::IndexPresenter.new(notifications_scope, params: params)

      render json: V2::Notifications::IndexView.render(presenter), status: :ok
    end

    def read
      notification.update(read_at: Time.current) if notification.read_at.blank?

      render json: V2::Notifications::Serializer.render(notification), status: :ok
    end

    def read_all
      notifications_to_read.update_all(read_at: Time.current)
      presenter = V2::Notifications::IndexPresenter.new(notifications_to_read, params: params)

      render json: V2::Notifications::IndexView.render(presenter), status: :ok
    end

    private

    def notifications_scope
      Notification
        .includes(:actor, notifiable: %i[evaluable recruit employee])
        .where(recipient: current_user)
    end

    def notifications_to_read
      @notifications_to_read ||=
        notifications_scope.where('created_at < ?', params[:latest_fetch_at])
    end

    def notification
      @notification ||= notifications_scope.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @notification

      @notification
    end
  end
end
