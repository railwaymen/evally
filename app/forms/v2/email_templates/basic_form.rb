# frozen_string_literal: true

module V2
  module EmailTemplates
    class BasicForm
      attr_reader :email_template

      def initialize(email_template, params:)
        @email_template = email_template

        @email_template.assign_attributes(params)
      end

      def save
        validate_email_template!

        @email_template.save
      end

      private

      def validate_email_template!
        return if @email_template.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @email_template.errors.full_messages)
      end
    end
  end
end
