# frozen_string_literal: true

module V2
  module Templates
    class BasicForm
      attr_reader :template

      def initialize(template, params:, user:)
        @template = template
        @user = user

        @template.assign_attributes(
          sections_attributes: params[:sections],
          **params.except('sections')
        )
      end

      def save
        validate_template!
        @template.save!
      end

      private

      def validate_template!
        return if @template.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @template.errors.full_messages)
      end
    end
  end
end
