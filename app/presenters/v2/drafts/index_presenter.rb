# frozen_string_literal: true

module V2
  module Drafts
    class IndexPresenter
      def initialize(user)
        @user = user
      end

      def drafts
        drafts_scope.joins(employees_join)
                    .where.not(employees: { state: :archived })
                    .order(updated_at: :desc)
      end

      def employees
        employees_scope.order(first_name: :asc)
      end

      def templates
        Template.for_employees.includes(:creator).order(name: :asc)
      end

      private

      def drafts_scope
        Pundit.policy_scope!(@user, [:v2, Evaluation]).draft
      end

      def employees_scope
        Pundit.policy_scope!(@user, [:v2, Employee]).where.not(state: :archived)
      end

      def employees_join
        "
          LEFT JOIN employees
            ON evaluations.evaluable_id = employees.id AND evaluations.evaluable_type = 'Employee'
        "
      end
    end
  end
end
