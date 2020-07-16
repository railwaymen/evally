# frozen_string_literal: true

module V2
  module Dashboard
    class ShowPresenter
      delegate :setting, to: :@user

      def initialize(user)
        @user = user
      end

      def employees
        V2::Dashboard::UpcomingQuery
          .new(employees_scope).call.limit(setting.default_upcoming_items || 5)
      end

      def drafts
        drafts_scope.order(updated_at: :desc).limit(setting.default_draft_items || 5)
      end

      def activities
        activities_scope.includes(:user).order(created_at: :desc).limit(5)
      end

      private

      def activities_scope
        V2::ActivityPolicy::Scope.new(@user, Activity).resolve
      end

      def employees_scope
        @user.admin? ? Employee.hired : @user.employees
      end

      def drafts_scope
        V2::EvaluationPolicy::EmployableScope
          .new(@user, Evaluation).resolve.draft.includes(:evaluable)
      end
    end
  end
end
