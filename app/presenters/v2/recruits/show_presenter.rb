# frozen_string_literal: true

module V2
  module Recruits
    class ShowPresenter
      attr_reader :recruit

      def initialize(recruit, user)
        @recruit = recruit
        @user = user
      end

      def evaluators
        User.active
      end

      def evaluations
        @evaluations ||= @recruit.evaluations.order(completed_at: :desc)
      end

      def evaluation
        @evaluation ||= evaluations[0]
      end

      def templates
        Template.for_recruits.includes(:creator).order(name: :asc)
      end

      def sections
        Pundit.policy_scope!(@user, [:v2, sections_scope])
      end

      def comments
        @recruit.comments.order(created_at: :desc)
      end

      private

      def sections_scope
        return Section.none if evaluation.nil?

        evaluation.sections.order(position: :asc)
      end
    end
  end
end
