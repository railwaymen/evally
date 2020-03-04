# frozen_string_literal: true

module V2
  module Recruitments
    class UpdateForm
      def initialize(recruitment, params:, user:)
        @recruitment = recruitment

        @recruitment.assign_attributes(params.fetch(:recruitment, {}))
        candidate.assign_attributes(params.fetch(:candidate, {}))

        @user = user
      end

      def save
        validate_candidate_and_recruitment!

        ActiveRecord::Base.transaction do
          candidate.save!
          @recruitment.save!

          create_activity!
        end
      end

      def recruitment
        V2::Recruitments::BasicQuery.call.find_by(id: @recruitment.id)
      end

      private

      def validate_candidate_and_recruitment!
        return if [candidate.valid?, @recruitment.valid?].all?

        raise ErrorResponderService.new(
          :invalid_record, 422, candidate.errors.full_messages | @recruitment.errors.full_messages
        )
      end

      def candidate
        @candidate ||= @recruitment.candidate
      end

      def create_activity!
        @user.activities.create!(
          action: 'update',
          activable: @recruitment,
          activable_name: @recruitment.position
        )
      end
    end
  end
end
