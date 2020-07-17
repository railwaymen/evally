# frozen_string_literal: true

module V2
  module Employees
    class ArchiveForm
      include ActiveModel::Validations

      attr_reader :employee

      delegate :archived_on, to: :employee
      delegate :notify_evaluator!, :notify_admins!, to: :notifier_service

      validate :archived_on_presence
      validate :existing_drafts

      def initialize(employee, params:, user:)
        @employee = employee
        @user = user

        @employee.assign_attributes(params)
      end

      def save
        validate_employee!

        ActiveRecord::Base.transaction do
          notify_evaluator!(:archive)
          notify_admins!(:archive)

          @employee.update!(evaluator_id: nil, next_evaluation_on: nil)
        end
      end

      private

      def validate_employee!
        return if valid?

        raise ErrorResponderService.new(:invalid_record, 422, errors.full_messages)
      end

      def archived_on_presence
        return if @employee.archived_on.present?

        errors.add(:base, I18n.t('activerecord.errors.messages.missing_archive_date'))
      end

      def existing_drafts
        return unless @employee.evaluations.draft.exists?

        errors.add(:base, I18n.t('activerecord.errors.messages.has_draft_evaluations'))
      end

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @employee, actor: @user)
      end
    end
  end
end
