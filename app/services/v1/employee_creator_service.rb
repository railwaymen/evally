module V1
  class EmployeeCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @model if create_new_employee && notify
    end

    private

    def create_new_employee
      @model = @user.employees.build(employee_params)

      unless @model.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @model.errors.messages)
      end

      @model.save!
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
