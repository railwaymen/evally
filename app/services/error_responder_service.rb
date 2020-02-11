# frozen_string_literal: true

class ErrorResponderService < StandardError
  attr_reader :identifier, :status, :details

  def initialize(identifier, status = :bad_request, details = [])
    @identifier = identifier
    @status = status
    @details = details
  end

  def translated_payload
    I18n.translate("errors.#{@identifier}")
  end
end
