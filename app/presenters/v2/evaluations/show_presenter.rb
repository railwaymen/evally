# frozen_string_literal: true

module V2
  module Evaluations
    class ShowPresenter
      attr_reader :evaluation

      def initialize(evaluation)
        @evaluation = evaluation
      end

      def sections
        @evaluation.sections.order(position: :asc)
      end
    end
  end
end
