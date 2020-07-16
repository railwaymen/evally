# frozen_string_literal: true

module V2
  module Evaluations
    class EmployableUpdateForm
      attr_reader :draft

      delegate :employee, to: :draft
      delegate :notify_evaluator!, :notify_admins!, to: :notifier_service

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

        ActiveRecord::Base.transaction do
          if @draft.completed?
            save_evaluation_dates!

            notify_evaluator!(:complete_employee_evaluation)
            notify_admins!(:complete_employee_evaluation)
          end

          @draft.save!
        end
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

      def save_evaluation_dates!
        employee.update!(
          last_evaluation_on: @draft.completed_at,
          next_evaluation_on: @params[:next_evaluation_on]
        )
      end

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @draft, actor: @user)
      end
    end
  end
end
