# frozen_string_literal: true

module V2
  module Errors
    class Serializer < Blueprinter::Base
      identifier :identifier

      field :code do |error|
        Rack::Utils.status_code(error.status)
      end

      field :title do |error|
        error.translated_payload[:title]
      end

      field :message do |error|
        error.translated_payload[:message]
      end

      fields :details
    end
  end
end
