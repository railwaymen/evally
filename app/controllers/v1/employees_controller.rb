module V1
  class EmployeesController < ApplicationController
    before_action :authenticate!

    before_action :set_employee, only: :update

    # GET /v1/employees
    #
    def index
      employees = current_user.employees.order(last_name: :asc)

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
      employee = V1::EmployeeUpdaterService.new(attributes: params[:employee], employee: @employee).call

      render json: V1::EmployeeSerializer.new(employee).serialized_json, status: 200
    end

    private

    def set_employee
      @employee = current_user.employees.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @employee
    end

  end
end
