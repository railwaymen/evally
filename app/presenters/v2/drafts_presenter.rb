# frozen_string_literal: true

module V2
  class DraftsPresenter
    def drafts
      V2::EvaluationsQuery.call(Evaluation.draft).order(updated_at: :desc)
    end

    def employees
      Employee.order(first_name: :asc)
    end

    def templates
      Template.order(name: :asc)
    end
  end
end
