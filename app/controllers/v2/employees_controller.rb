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

    private

    def create_form
      @create_form ||= V2::EmployeeCreateForm.new(
        create_params,
        user: current_user
      )
    end

    def create_params
      params.require(:employee).permit(
        :first_name, :last_name, :position, :group, :hired_at, :position_set_at, :next_evaluation_at
      )
    end
  end
end
