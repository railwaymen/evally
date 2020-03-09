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

      # def evaluation; end

      # def comments; end
    end
  end
end
