module V1
  class ErrorSerializer < Blueprinter::Base
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

    field :details do |error|
      error.details
    end
  end
end
