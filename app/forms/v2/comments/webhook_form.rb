# frozen_string_literal: true

module V2
  module Comments
    class WebhookForm
      attr_reader :comment

      delegate :save, to: :comment

      def initialize(recruit:, params:)
        @comment = recruit.comments.find_or_initialize_by(change_id: params[:change_id])

        @comment.assign_attributes(
          created_by: 'bot',
          **params
        )
      end
    end
  end
end
