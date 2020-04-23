# frozen_string_literal: true

module V2
  module Employees
    class FormPresenter
      def positions
        Employee.distinct(:position).order(:position).pluck(:position)
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
