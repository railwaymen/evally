# frozen_string_literal: true

module V2
  class EmployeesController < ApplicationController
    before_action :authenticate!

    def index
      employees = V2::EmployeesQuery.call

      render json: V2::EmployeeSerializer.render(employees, view: :index), status: :ok
    end

    def create
      create_form.save

      render json: V2::EmployeeSerializer.render(create_form.employee), status: :created
    end

    def update
      update_form.save

      render json: V2::EmployeeSerializer.render(update_form.employee), status: :ok
    end

    private

    def employee
      @employee ||= Employee.find_by(id: params[:id])
      raise V1::ErrorResponderService.new(:record_not_found, 404) unless @employee

      @employee
    end

    def create_form
      @create_form ||= V2::EmployeeForm.new(
        current_user.employees.build,
        params: employee_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::EmployeeForm.new(
        employee,
        params: employee_params,
        user: current_user
      )
    end

    def employee_params
      params.require(:employee).permit(
        :first_name, :last_name, :position, :group, :hired_at, :position_set_at, :next_evaluation_at
      )
    end
  end
end
