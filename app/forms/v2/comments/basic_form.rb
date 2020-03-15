# frozen_string_literal: true

module V2
  module Comments
    class BasicForm
      attr_reader :comment

      def initialize(comment, params:)
        @comment = comment

        @comment.assign_attributes(params)
      end

      def save
        validate_comment!

        @comment.save!
      end

      private

      def validate_comment!
        return if @comment.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @comment.errors.full_messages)
      end
    end
  end
end
