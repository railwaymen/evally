module V1
  class EmployeeCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @form.model if create_new_employee && notify
    end

    private

    def create_new_employee
      @form = V1::EmployeeForm.new(@user.employees.build)

      unless @form.validate(@attributes)
        raise V1::ErrorResponderService.new(:invalid_record, 422, @form.errors.messages)
      end

      @form.save
    end

    def notify
      # TODO: (FF) create notification to display in dashboard menu
      true
    end

  end
end
