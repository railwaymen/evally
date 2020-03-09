# frozen_string_literal: true

module V2
  module RecruitDocuments
    class NewPresenter
      def statuses
        RecruitDocument.statuses.keys
      end

      def groups
        RecruitDocument.distinct(:group).order(:group).pluck(:group)
      end

      def positions
        RecruitDocument.distinct(:position).order(:position).pluck(:position)
      end

      def evaluators
        User.all
      end
    end
  end
end
