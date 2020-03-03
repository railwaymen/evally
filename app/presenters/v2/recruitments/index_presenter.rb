# frozen_string_literal: true

module V2
  module Recruitments
    class IndexPresenter
      def recruitments
        V2::Recruitments::BasicQuery.call
      end

      def groups
        Recruitment.distinct(:group).order(:group).pluck(:group)
      end

      def statuses
        Recruitment.distinct(:status).order(:status).pluck(:status)
      end
    end
  end
end
