# frozen_string_literal: true

module V2
  module Employees
    class IndexPresenter
      def initialize(user, state: 'hired')
        @user = user
        @state = state
      end

      def employees
        V2::EmployeesQuery.call(scope)
      end

      def evaluators
        User.all if @state == 'hired'
      end

      private

      def scope
        EmployeePolicy::Scope.new(@user, Employee).resolve.where(state: @state)
      end
    end
  end
end
