# frozen_string_literal: true

module V2
  module Employees
    class ArchiveForm
      include ActiveModel::Validations

      attr_reader :employee, :archived_on

      validate :archived_on_presence
      validate :existing_drafts

      def initialize(employee, params:, user:)
        @employee = employee
        @archived_on = params[:archived_on]
        @user = user
      end

      def save
        validate_employee!

        ActiveRecord::Base.transaction do
          notify_evaluator!

          @employee.update!(state: 'archived', archived_on: @archived_on, evaluator_id: nil)
        end
      end

      private

      def validate_employee!
        return if valid? && @employee.errors.blank?

        raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
      end

      def archived_on_presence
        return if @archived_on.present?

        @employee.errors.add(:archived_on, :blank)
      end

      def existing_drafts
        return unless @employee.evaluations.draft.exists?

        @employee.errors.add(:base, :has_draft_evaluations)
      end

      def notify_evaluator!
        return if @employee.evaluator_id.blank?

        Notification.create!(
          actor: @user,
          recipient: @employee.evaluator,
          action: 'archive',
          notifiable: @employee
        )
      end
    end
  end
end
