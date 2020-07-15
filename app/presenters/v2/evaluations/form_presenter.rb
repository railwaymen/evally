# frozen_string_literal: true

module V2
  module Evaluations
    class FormPresenter
      def initialize(user)
        @user = user
      end

      def employees
        @user.employees.order(first_name: :asc)
      end

      def templates
        Template.for_employees.includes(:creator).order(name: :asc)
      end
    end
  end
end
