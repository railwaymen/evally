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

      @employee.evaluations.draft.destroy_all unless @employee.hired?
      @employee.save!
    end

    def employee_params
      @attributes.permit(
        :first_name,
        :last_name,
        :position,
        :hired_at,
        :next_evaluation_at,
        :state,
        :released_at
      )
    end

    def add_activity
      action = @employee.hired? ? 'update' : 'archive'
      @user.activities.create!(action: action, activable: @employee, activable_name: @employee.fullname)
    end

  end
end
