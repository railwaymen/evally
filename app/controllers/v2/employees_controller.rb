# frozen_string_literal: true

module V2
  class EmployeesController < ApplicationController
    before_action :authenticate!
    before_action :authorize!

    def index
      presenter = V2::EmployeesPresenter.new(employees_scope)

      render json: V2::Views::EmployeesView.render(presenter), status: :ok
    end

    def show
      presenter = V2::EmployeePresenter.new(employee)

      render json: V2::Views::EmployeeView.render(presenter), status: :ok
    end

    def create
      create_form.save

      render json: V2::EmployeeSerializer.render(create_form.employee), status: :created
    end

    def update
      update_form.save

      render json: V2::EmployeeSerializer.render(update_form.employee), status: :ok
    end

    def skills
      render json: V2::SkillsQuery.call, status: :ok
    end

    def search
      employees = V2::EmployeesSearchQuery.call(employees_scope, params: params)

      render json: V2::EmployeeSerializer.render(employees, view: :search), status: :ok
    end

    def overview
      presenter = V2::EmployeesOverviewPresenter.new

      render json: V2::Views::EmployeesOverviewView.render(presenter), status: :ok
    end

    def destroy
      ActiveRecord::Base.transaction do
        employee.destroy!

        current_user.activities.create!(
          action: 'destroy',
          activable: employee,
          activable_name: employee.fullname
        )
      end

      head :no_content
    end

    private

    def authorize!
      authorize [:v2, Employee]
    end

    def employees_scope
      policy_scope([:v2, Employee])
    end

    def employee
      @employee ||= V2::EmployeesQuery.call(employees_scope).find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @employee

      @employee
    end

    def create_form
      @create_form ||= V2::EmployeeForm.new(
        Employee.new,
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
        :first_name, :last_name, :position, :group, :hired_on, :position_set_on, :evaluator_id,
        :next_evaluation_on
      )
    end
  end
end
