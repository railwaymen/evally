# frozen_string_literal: true

module V2
  module Employees
    class IndexPresenter
      def initialize(scope, state: :hired)
        @scope = scope.where(state: state)
      end

      def employees
        V2::Employees::BasicQuery.new(@scope).call
      end

      def groups
        Employee.distinct(:group).order(:group).pluck(:group)
      end

      def evaluators
        User.all
      end
    end
  end
end
