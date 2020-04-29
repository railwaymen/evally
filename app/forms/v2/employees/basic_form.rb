# frozen_string_literal: true

module V2
  module Employees
    class BasicForm
      attr_reader :employee

      def initialize(employee, params:, user:)
        @employee = employee
        @user = user

        @employee.assign_attributes(params)
      end

      def save
        validate_employee!

        ActiveRecord::Base.transaction do
          log_position_change!
          notify_evaluator!

          @employee.save!
        end
      end

      private

      def validate_employee!
        return if @employee.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
      end

      def log_position_change!
        return unless @employee.persisted? && @employee.position_changed?

        @employee.position_changes.create!(
          previous_position: @employee.position_was,
          current_position: @employee.position,
          changed_on: @employee.position_set_on
        )
      end

      def notify_evaluator!
        return if @employee.evaluator_id.blank?

        action = @employee.evaluator_id_changed? ? 'assign' : 'update'

        Notification.create!(
          actor: @user,
          recipient: @employee.evaluator,
          action: action,
          notifiable: @employee
        )
      end
    end
  end
end
