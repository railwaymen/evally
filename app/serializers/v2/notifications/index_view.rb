# frozen_string_literal: true

module V2
  module Notifications
    class IndexView < Blueprinter::Base
      fields :total_pages, :unread_count

      association :notifications, blueprint: V2::Notifications::Serializer, default: []
    end
  end
end
