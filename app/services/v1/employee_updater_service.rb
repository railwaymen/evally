# frozen_string_literal: true

module V1
  class EmployeeUpdaterService
    def initialize(attributes:, employee:, user:)
      @attributes = attributes
      @employee = employee
      @user = user
    end

    def call
      @employee if update_employee && add_activity
    end

    private

    def update_employee
      @employee.attributes = employee_params

      unless @employee.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
      end

      ActiveRecord::Base.transaction do
        @employee.evaluations.draft.destroy_all unless @employee.hired?
        log_position_change if @employee.position_changed?

        @employee.save!
      end
    end

    def employee_params
      @attributes.permit(
        :first_name, :last_name, :position, :group, :hired_on, :next_evaluation_at, :state,
        :released_at, :position_set_at
      )
    end

    def add_activity
      action = @employee.hired? ? 'update' : 'archive'
      @user.activities.create!(
        action: action,
        activable: @employee,
        activable_name: @employee.fullname
      )
    end

    def log_position_change
      @employee.position_changes.create!(
        previous_position: @employee.position_was,
        current_position: @employee.position,
        changed_at: employee_params[:position_set_at]
      )
    end
  end
end
