module V1
  class EmployeeUpdaterService

    def initialize(attributes:, employee:)
      @attributes = attributes
      @employee = employee
    end

    def call
      @form.model if update_employee && notify
    end

    private

    def update_employee
      @form = V1::EmployeeForm.new(@employee, @attributes)

      unless @form.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @form.errors.messages)
      end

      @form.submit!
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

  end
end
