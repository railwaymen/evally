# frozen_string_literal: true

module V1
  class EmployeesController < ApplicationController
    before_action :authenticate!

    before_action :set_employee, only: %i[update destroy]

    # GET /v1/employees
    #
    def index
      employees = Employee.includes(:latest_evaluation).by_state(params[:state])
                          .order(last_name: :asc)

      render json: V1::EmployeeSerializer.render(employees, view: :evaluated), status: :ok
    end

    # GET /v1/employees/:id
    #
    def show
      employee = Employee.includes(:latest_evaluation).hired.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless employee

      render json: V1::EmployeeSerializer.render(employee, view: :evaluated), status: :ok
    end

    # GET /v1/employees/chart
    #
    def chart
      render json: V1::EmployeesChartDataProvider.call, status: :ok
    end

    # GET /v1/employees/search
    #
    def search
      employees = V1::EmployeesSearchDataProvider.new(params[:query]).call

      render json: V1::EmployeeSerializer.render(employees, view: :evaluated), status: :ok
    end

    # GET /v1/employees/skills
    #
    def skills
      render json: V1::EmployeesSkillsListProvider.call, status: :ok
    end

    # # POST /v1/employees
    #
    def create
      employee = V1::EmployeeCreatorService.new(
        attributes: params[:employee],
        user: current_user
      ).call

      render json: V1::EmployeeSerializer.render(employee, view: :evaluated), status: :ok
    end

    # # PUT /v1/employees/:id
    #
    def update
      employee = V1::EmployeeUpdaterService.new(
        attributes: params[:employee],
        employee: @employee,
        user: current_user
      ).call

      render json: V1::EmployeeSerializer.render(employee, view: :evaluated), status: :ok
    end

    # # DELETE /v1/employees/:id
    #
    def destroy
      @employee.destroy
      current_user.activities.create(
        action: 'destroy',
        activable: @employee,
        activable_name: @employee.fullname
      )

      render json: {}, status: :no_content
    end

    private

    def set_employee
      @employee = Employee.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @employee
    end
  end
end
