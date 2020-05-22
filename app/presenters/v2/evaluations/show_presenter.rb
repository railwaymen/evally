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
        V2::SectionPolicy::Scope.new(@user, sections_scope).resolve
      end

      private

      def sections_scope
        @evaluation.sections.order(position: :asc)
      end
    end
  end
end
