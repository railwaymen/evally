# frozen_string_literal: true

module V2
  module Notifications
    class Serializer < Blueprinter::Base
      identifier :id

      fields :body, :path, :created_at

      field :unread do |notification|
        notification.read_at.blank?
      end
    end
  end
end
