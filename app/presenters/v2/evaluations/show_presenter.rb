# frozen_string_literal: true

module V2
  module Evaluations
    class ShowPresenter
      attr_reader :evaluation

      def initialize(evaluation, user)
        @evaluation = evaluation
        @user = user
      end

      def sections
        Pundit.policy_scope!(@user, [:v2, sections_scope])
      end

      private

      def sections_scope
        @evaluation.sections.order(position: :asc)
      end
    end
  end
end
