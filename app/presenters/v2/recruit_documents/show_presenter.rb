# frozen_string_literal: true

module V2
  module RecruitDocuments
    class ShowPresenter
      attr_reader :recruit_document

      def initialize(recruit_document)
        @recruit_document = recruit_document
      end

      def templates
        Template.for_recruits.includes(:creator).order(name: :asc)
      end

      # def status_changes; end

      def evaluations
        @recruit_document.recruit.evaluations.order(completed_at: :desc)
      end

      def evaluation
        evaluations.first
      end

      def sections
        return if evaluation.nil?

        evaluation.sections.order(position: :asc)
      end

      # def comments; end
    end
  end
end
