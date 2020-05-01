# frozen_string_literal: true

module V2
  module Notifications
    class Serializer < Blueprinter::Base
      identifier :id

      fields :body, :notifiable_path, :unread, :created_at
    end
  end
end
