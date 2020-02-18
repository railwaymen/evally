# frozen_string_literal: true

module V2
  class DraftsPresenter
    def initialize(user)
      @user = user
    end

    def drafts
      drafts_scope.includes(:employee).order(updated_at: :desc)
    end

    def employees
      employees_scope.order(first_name: :asc)
    end

    def templates
      Template.order(name: :asc)
    end

    private

    def drafts_scope
      Pundit.policy_scope!(@user, [:v2, Evaluation]).draft
    end

    def employees_scope
      Pundit.policy_scope!(@user, [:v2, Employee])
    end
  end
end
