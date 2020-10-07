# frozen_string_literal: true

require 'mail'

module EmailValidatable
  extend ActiveSupport::Concern

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      mail_address = Mail::Address.new(value)

      unless mail_address.address =~ URI::MailTo::EMAIL_REGEXP
        record.errors.add(attribute, options[:message] || invalid_email_message)
      end
    rescue Mail::Field::ParseError
      record.errors.add(attribute, options[:message] || invalid_email_message)
    end

    private

    def invalid_email_message
      I18n.t('activerecord.errors.messages.invalid_email')
    end
  end
end
