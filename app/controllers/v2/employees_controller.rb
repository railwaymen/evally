# frozen_string_literal: true

module V2
  class EmployeesController < ApplicationController
    before_action :authenticate!

    def index
      employees = V2::EmployeesQuery.call

      render json: V2::EmployeeSerializer.render(employees, view: :index), status: :ok
    end
  end
end
