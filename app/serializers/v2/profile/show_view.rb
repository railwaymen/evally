# frozen_string_literal: true

module V2
  module Profile
    class ShowView < Blueprinter::Base
      fields :unread_notifications_count

      association :user, blueprint: V2::Users::Serializer, default: {}

      association :setting, blueprint: V2::Settings::Serializer, default: {}

      association :notifications, blueprint: V2::Notifications::Serializer, default: []
    end
  end
end
