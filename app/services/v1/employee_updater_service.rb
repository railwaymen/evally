module V1
  class EmployeeUpdaterService

    def initialize(attributes:, employee:)
      @attributes = attributes
      @employee = employee
    end

    def call
      @employee if update_employee && notify
    end

    private

    def update_employee
      @employee.attributes = employee_params

      unless @employee.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @employee.errors.full_messages)
      end

      @employee.save!
    end

    def employee_params
      @attributes.permit(:first_name, :last_name, :position, :hired_at, :last_evaluation_at, :next_evaluation_at)
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

  end
end
