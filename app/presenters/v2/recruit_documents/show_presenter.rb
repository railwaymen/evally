# frozen_string_literal: true

module V2
  module RecruitDocuments
    class ShowPresenter
      attr_reader :recruit_document

      def initialize(user, recruit_document)
        @user = user
        @recruit_document = recruit_document
      end

      def templates
        Template.for_recruits.includes(:creator).order(name: :asc)
      end

      # def status_changes; end

      def evaluations
        @evaluations ||= @recruit_document.recruit.evaluations.order(completed_at: :desc)
      end

      def evaluation
        @evaluation ||= evaluations.to_a.first
      end

      def sections
        Pundit.policy_scope!(@user, [:v2, sections_scope])
      end

      private

      def sections_scope
        return Section.none if evaluation.nil?

        evaluation.sections.order(position: :asc)
      end
    end
  end
end
