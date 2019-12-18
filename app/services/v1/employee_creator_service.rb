# frozen_string_literal: true

module V1
  class EmployeeCreatorService
    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @employee if create_new_employee && add_activity
    end

    private

    def create_new_employee
      @employee = @user.employees.build(employee_params)

      unless @employee.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
      end

      @employee.save!
    end

    def employee_params
      @attributes.permit(
        :first_name,
        :last_name,
        :position,
        :group,
        :hired_at,
        :last_evaluation_at,
        :next_evaluation_at
      )
    end

    def add_activity
      @user.activities.create!(
        action: 'create',
        activable: @employee,
        activable_name: @employee.fullname
      )
    end
  end
end
