# frozen_string_literal: true

module V2
  module Settings
    class UpdateForm
      attr_reader :setting

      def initialize(setting, params:)
        @setting = setting

        @setting.assign_attributes(params)
      end

      def save
        validate_setting!
        @setting.save
      end

      private

      def validate_setting!
        return if @setting.valid?

        raise ErrorResponderService.new(:invalid_record, 422, @setting.errors.full_messages)
      end
    end
  end
end
