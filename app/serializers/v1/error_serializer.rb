module V1
  class ErrorSerializer
    include FastJsonapi::ObjectSerializer

    set_id :identifier

    attribute :code do |error|
      Rack::Utils.status_code(error.status)
    end

    attribute :title do |error|
      error.translated_payload[:title]
    end

    attribute :message do |error|
      error.translated_payload[:message]
    end

    attribute :details do |error|
      error.details
    end
  end
end
