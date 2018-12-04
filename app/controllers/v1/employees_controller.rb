module V1
  class EmployeesController < ApplicationController
    before_action :authenticate!

    before_action :set_employee, only: [:update, :destroy]

    # GET /v1/employees
    #
    def index
      employees = Employee.by_state(params[:state]).order(last_name: :asc)

      render json: V1::EmployeeSerializer.new(employees).serialized_json, status: 200
    end

    # # POST /v1/employees
    #
    def create
      employee = V1::EmployeeCreatorService.new(attributes: params[:employee], user: current_user).call

      render json: V1::EmployeeSerializer.new(employee).serialized_json, status: 200
    end

    # # PUT /v1/employees/:id
    #
    def update
      employee = V1::EmployeeUpdaterService.new(attributes: params[:employee], employee: @employee, user: current_user).call

      render json: V1::EmployeeSerializer.new(employee).serialized_json, status: 200
    end

    # # DELETE /v1/employees/:id
    #
    def destroy
      @employee.destroy
      current_user.activities.create(action: 'destroy', activable: @employee, activable_name: @employee.fullname)

      render json: {}, status: 204
    end

    private

    def set_employee
      @employee = Employee.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @employee
    end

  end
end
