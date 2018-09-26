module V1
  class EmployeesController < ApplicationController
    before_action :authenticate!

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
  end
end