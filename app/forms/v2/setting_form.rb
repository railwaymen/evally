# frozen_string_literal: true

module V2
  class SettingForm
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

      raise V1::ErrorResponderService.new(:invalid_record, 422, @setting.errors.full_messages)
    end
  end
end
