# frozen_string_literal: true

module V2
  module Notifications
    class UpcomingEvaluationsPresenter
      def initialize(user)
        @user = user
      end

      def fresh_employees
        @fresh_employees ||= employees_scope.where(
          "
            last_evaluation_on IS NULL AND
              next_evaluation_on IS NULL AND
              hired_on < CURRENT_DATE - '2 months'::interval
          "
        )
      end

      def scheduled_employees
        @regular_employees ||= employees_scope.where(
          "
            next_evaluation_on IS NOT NULL
              AND (
                TO_CHAR(next_evaluation_on, 'YYYY-MM') = TO_CHAR(CURRENT_DATE, 'YYYY-MM')
                  OR next_evaluation_on < CURRENT_DATE
              )
          "
        )
      end

      def unscheduled_employees
        @unscheduled_employees ||= employees_scope.where(
          "last_evaluation_on IS NOT NULL AND next_evaluation_on IS NULL"
        )
      end

      def mail_subject
        "Upcoming Evaluations Reminder - #{Date.current.strftime('%B %Y')}"
      end

      private

      def employees_scope
        V2::EmployeePolicy::Scope.new(@user, Employee).resolve
      end
    end
  end
end
