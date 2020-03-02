# frozen_string_literal: true

module V2
  module Recruitments
    class BasicQuery
      def self.call(scope = Recruitment.all)
        scope.joins(:candidate).select(fields).order(received_at: :desc)
      end

      def self.fields
        [
          'candidates.first_name AS first_name',
          'candidates.last_name AS last_name',
          'candidates.email AS email',
          'candidates.gender AS gender',
          'recruitments.*'
        ].join(', ')
      end

      private_class_method :fields
    end
  end
end
