# frozen_string_literal: true

module V2
  class EvaluationPresenter
    attr_reader :evaluation

    alias draft evaluation

    def initialize(evaluation)
      @evaluation = evaluation
    end

    def sections
      @evaluation.sections.order(position: :asc)
    end
  end
end
