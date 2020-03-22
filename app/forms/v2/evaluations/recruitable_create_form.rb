# frozen_string_literal: true

module V2
  module Evaluations
    class RecruitableCreateForm
      attr_reader :draft

      def initialize(params, user:)
        @params = params
        @user = user
      end

      def save
        build_draft && validate_draft!

        @draft.save!
      end

      private

      def build_draft
        @draft = recruit.evaluations.build(
          state: :draft,
          position: @params.fetch('position', 'Unknown'),
          template_name: template.name,
          sections_attributes: sections
        )
      end

      def validate_draft!
        return if @draft.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @draft.errors.full_messages)
      end

      def recruit
        @recruit ||= Recruit.find_or_create_by(
          public_recruit_id: @params[:public_recruit_id]
        )
      end

      def template
        @template ||= Template.for_recruits.find_by(id: @params[:template_id])

        unless @template
          raise ErrorResponderService.new(:record_not_found, 404, ['Template does not exist'])
        end

        @template
      end

      def sections
        template.sections.collect do |section|
          section.attributes.slice('name', 'group', 'width', 'position', 'sensitive', 'skills')
        end
      end
    end
  end
end
