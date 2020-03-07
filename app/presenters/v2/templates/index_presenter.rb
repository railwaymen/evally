# frozen_string_literal: true

module V2
  module Templates
    class IndexPresenter
      def templates
        Template.includes(:creator).order(name: :asc)
      end

      def destinations
        Template.destinations.keys.collect { |val| { value: val, text: val.titleize } }
      end
    end
  end
end
