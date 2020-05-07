# frozen_string_literal: true

module V2
  module Employees
    class UpdateForm
      attr_reader :employee

      delegate :notify_evaluator!, :notify_admins!, to: :notifier_service

      def initialize(employee, params:, user:)
        @employee = employee
        @user = user

        @employee.assign_attributes(params)
      end

      def save
        validate_employee!

        ActiveRecord::Base.transaction do
          log_position_change!

          if @employee.changed?
            notify_evaluator!(@employee.evaluator_id_changed? ? :assign_me : :update)
            notify_admins!(@employee.evaluator_id_changed? ? :assign_evaluator : :update)
          end

          @employee.save!
        end
      end

      private

      def validate_employee!
        return if @employee.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
      end

      def log_position_change!
        return unless @employee.position_changed?

        @employee.position_changes.create!(
          previous_position: @employee.position_was,
          current_position: @employee.position,
          changed_on: @employee.position_set_on
        )
      end

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @employee, actor: @user)
      end
    end
  end
end
