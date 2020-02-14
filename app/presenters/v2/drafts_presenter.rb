# frozen_string_literal: true

module V2
  class DraftsPresenter
    def drafts
      Evaluation.draft.includes(:employee).order(updated_at: :desc)
    end

    def employees
      Employee.order(first_name: :asc)
    end

    def templates
      Template.order(name: :asc)
    end
  end
end
