# frozen_string_literal: true

module V2
  class EmployeeForm
    attr_reader :employee

    def initialize(employee, params:, user:)
      @employee = employee
      @user = user

      @employee.assign_attributes(params)
    end

    def save
      validate_employee!

      ActiveRecord::Base.transaction do
        log_position_change! if position_changed?
        create_activity!

        @employee.save!
      end
    end

    private

    def validate_employee!
      return if @employee.valid?

      raise ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
    end

    def log_position_change!
      @employee.position_changes.create!(
        previous_position: @employee.position_was,
        current_position: @employee.position,
        changed_at: @employee.position_set_on
      )
    end

    def position_changed?
      @employee.persisted? && @employee.position_changed?
    end

    def create_activity!
      @user.activities.create!(
        action: resolved_activity_action,
        activable: @employee,
        activable_name: @employee.fullname
      )
    end

    def resolved_activity_action
      @employee.new_record? ? 'create' : 'update'
    end
  end
end
