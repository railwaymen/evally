# frozen_string_literal: true

module V2
  class EmployeesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize!, only: %i[archived create update overview archive destroy]

    def index
      presenter = V2::Employees::IndexPresenter.new(
        employees_scope.by_group(params.dig(:group)).by_evaluator_id(params.dig(:evaluator_id))
      )

      render json: V2::Employees::IndexView.render(presenter), status: :ok
    end

    def archived
      presenter = V2::Employees::IndexPresenter.new(employees_scope, state: :archived)

      render json: V2::Employees::IndexView.render(presenter), status: :ok
    end

    def show
      presenter = V2::Employees::ShowPresenter.new(employee)

      render json: V2::Employees::ShowView.render(presenter), status: :ok
    end

    def form
      presenter = V2::Employees::FormPresenter.new

      render json: V2::Employees::FormView.render(presenter), status: :ok
    end

    def create
      create_form.save

      render json: V2::Employees::Serializer.render(create_form.detailed_employee), status: :created
    end

    def update
      update_form.save

      render json: V2::Employees::Serializer.render(update_form.employee), status: :ok
    end

    def skills
      render json: V2::Sections::SkillsQuery.new(target: :employees).call, status: :ok
    end

    def search
      employees = V2::Employees::SearchQuery.new(employees_scope.hired, params: params).call

      render json: V2::Employees::Serializer.render(employees, view: :search), status: :ok
    end

    def overview
      presenter = V2::Employees::OverviewPresenter.new

      render json: V2::Employees::OverviewView.render(presenter), status: :ok
    end

    def archive
      archive_form.save

      render json: V2::Employees::Serializer.render(archive_form.employee), status: :ok
    end

    def destroy
      employee.destroy!

      head :no_content
    end

    private

    def authorize!
      authorize([:v2, Employee])
    end

    def employees_scope
      V2::EmployeePolicy::Scope.new(current_user, Employee).resolve
    end

    def employee
      @employee ||= V2::Employees::DetailsQuery.new(employees_scope).call.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @employee

      @employee
    end

    def create_form
      @create_form ||= V2::Employees::CreateForm.new(
        Employee.new,
        params: employee_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::Employees::UpdateForm.new(
        employee,
        params: employee_params,
        user: current_user
      )
    end

    def archive_form
      @archive_form ||= V2::Employees::ArchiveForm.new(
        employee,
        params: employee_params,
        user: current_user
      )
    end

    def employee_params
      attributes = %i[first_name last_name position group hired_on position_set_on archived_on
                      next_evaluation_on]

      attributes.push(:evaluator_id) if current_user.admin?
      params.require(:employee).permit(*attributes)
    end
  end
end
