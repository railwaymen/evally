# frozen_string_literal: true

module V2
  class DashboardPresenter
    delegate :setting, to: :@user

    def initialize(user)
      @user = user
    end

    def employees
      Employee.order(next_evaluation_on: :desc).limit(setting.default_upcoming_items || 5)
    end

    def drafts
      drafts_scope.order(updated_at: :desc).limit(setting.default_draft_items || 5)
    end

    def activities
      Activity.includes(:user).order(created_at: :desc).limit(5)
    end

    def templates
      Template.order(name: :asc)
    end

    private

    def drafts_scope
      Evaluation.draft.includes(:employee)
    end
  end
end
