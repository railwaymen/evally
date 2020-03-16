# frozen_string_literal: true

module V2
  module Evaluations
    class RecruitableUpdateForm
      attr_reader :draft

      def initialize(draft, params:, user:)
        @draft = draft
        @params = params
        @user = user

        @draft.assign_attributes(
          state: resolve_state,
          completed_at: resolve_completed_at,
          sections_attributes: params[:sections]
        )
      end

      def save
        validate_draft!

        @draft.save!
      end

      private

      def validate_draft!
        return if @draft.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @draft.errors.full_messages)
      end

      def resolve_completed_at
        @params[:state] == 'completed' ? Time.now.utc : nil
      end

      def resolve_state
        @params[:state] == 'completed' ? :completed : :draft
      end
    end
  end
end
