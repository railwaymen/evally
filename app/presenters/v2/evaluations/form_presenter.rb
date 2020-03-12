# frozen_string_literal: true

module V2
  module Evaluations
    class FormPresenter
      def initialize(user)
        @user = user
      end

      def employees
        employees_scope.order(first_name: :asc)
      end

      def templates
        Template.for_employees.includes(:creator).order(name: :asc)
      end

      private

      def employees_scope
        Pundit.policy_scope!(@user, [:v2, Employee]).where.not(state: :archived)
      end
    end
  end
end
