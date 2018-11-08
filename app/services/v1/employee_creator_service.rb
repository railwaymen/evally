module V1
  class EmployeeCreatorService

    def initialize(attributes:, user:)
      @attributes = attributes
      @user = user
    end

    def call
      @model if create_new_employee && add_activity
    end

    private

    def create_new_employee
      @model = @user.employees.build(employee_params)

      unless @model.valid?
        raise V1::ErrorResponderService.new(:invalid_record, 422, @model.errors.full_messages)
      end

      @model.save!
    end

    def employee_params
      @attributes.permit(:first_name, :last_name, :position, :hired_at, :last_evaluation_at, :next_evaluation_at)
    end

    def add_activity
      @user.activities.create(action: 'create', activable: @model, activable_name: @model.fullname)
    end

  end
end
