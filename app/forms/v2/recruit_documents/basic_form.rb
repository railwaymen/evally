# frozen_string_literal: true

module V2
  module RecruitDocuments
    class BasicForm
      attr_reader :recruit_document

      def initialize(recruit_document, params:, user:)
        @recruit_document = recruit_document
        @user = user

        @recruit_document.assign_attributes(params)
      end

      def save
        validate_recruit_document!

        ActiveRecord::Base.transaction do
          @recruit_document.save!
          create_activity!

          recruit.save! if recruit.new_record?
        end
      end

      private

      def validate_recruit_document!
        return if @recruit_document.valid?

        raise ErrorResponderService.new(
          :invalid_record, 422, @recruit_document.errors.full_messages
        )
      end

      def recruit
        @recruit ||= Recruit.find_or_initialize_by(
          human_resources_id: @recruit_document.encrypted_email
        )
      end

      def create_activity!
        @user.activities.create!(
          action: resolve_activity_action,
          activable: recruit,
          activable_name: @recruit_document.position
        )
      end

      def resolve_activity_action
        recruit.new_record? ? 'create' : 'update'
      end
    end
  end
end
