# frozen_string_literal: true

module V2
  module Recruits
    class WebhookForm
      attr_reader :recruit

      delegate :save, to: :recruit

      def initialize(params:)
        @recruit = Recruit.find_or_initialize_by(public_recruit_id: params[:public_recruit_id])

        @recruit.assign_attributes(params)
      end
    end
  end
end
