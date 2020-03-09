# frozen_string_literal: true

module V2
  module Drafts
    class IndexPresenter
      def initialize(user)
        @user = user
      end

      def drafts
        drafts_scope.joins(:employee)
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
    end
  end
end
