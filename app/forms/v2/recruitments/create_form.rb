# frozen_string_literal: true

module V2
  module Recruitments
    class CreateForm
      def initialize(params:, user:)
        @candidate_params = params.fetch(:candidate, {})
        @recruitment_params = params.fetch(:recruitment, {})

        @recruitment = candidate.recruitments.build(@recruitment_params)

        @user = user
      end

      def save
        validate_recruitment!

        ActiveRecord::Base.transaction do
          @recruitment.save!
          create_activity!
        end
      end

      def recruitment
        V2::Recruitments::BasicQuery.call.find_by(id: @recruitment.id)
      end

      private

      def validate_recruitment!
        return if @recruitment.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @recruitment.errors.full_messages)
      end

      def candidate
        @candidate ||=
          Candidate.find_or_create_by(email: @candidate_params[:email]) do |c|
            c.assign_attributes(@candidate_params)
          end

        unless @candidate.persisted?
          raise ErrorResponderService.new(:invalid_record, 422, @candidate.errors.full_messages)
        end

        @candidate
      end

      def create_activity!
        @user.activities.create!(
          action: 'create',
          activable: @recruitment,
          activable_name: @recruitment.position
        )
      end
    end
  end
end
