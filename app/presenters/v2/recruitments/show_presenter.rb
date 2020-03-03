# frozen_string_literal: true

module V2
  module Recruitments
    class ShowPresenter
      attr_reader :recruitment

      def initialize(recruitment)
        @recruitment = recruitment
      end

      # def status_changes; end

      # def evaluation; end

      # def comments; end
    end
  end
end
