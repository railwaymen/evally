# frozen_string_literal: true

module V2
  module Templates
    class BasicForm
      attr_reader :template

      def initialize(template, params:, user:)
        @template = template
        @user = user

        @template.assign_attributes(
          sections_attributes: params[:sections],
          name: params[:name]
        )
      end

      def save
        validate_template!

        ActiveRecord::Base.transaction do
          create_activity!
          @template.save!
        end
      end

      private

      def validate_template!
        return if @template.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @template.errors.full_messages)
      end

      def create_activity!
        @user.activities.create!(
          action: resolved_activity_action,
          activable: @template,
          activable_name: @template.name
        )
      end

      def resolved_activity_action
        @template.new_record? ? 'create' : 'update'
      end
    end
  end
end
