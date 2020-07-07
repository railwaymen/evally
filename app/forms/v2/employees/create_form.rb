# frozen_string_literal: true

module V2
  module Employees
    class CreateForm
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
          notify_evaluator!(:assign_me)
          notify_admins!(:create)

          @employee.save!
        end
      end

      def detailed_employee
        V2::Employees::DetailsQuery.new(Employee.all).call.find_by(id: @employee.id)
      end

      private

      def validate_employee!
        return if @employee.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
      end

      def notifier_service
        @notifier_service ||= V2::NotifierService.new(notifiable: @employee, actor: @user)
      end
    end
  end
end
