# frozen_string_literal: true

module V2
  module Browse
    class EmployeesController < ApplicationController
      def show
        presenter = V2::Employees::ShowPresenter.new(employee)

        render json: V2::Employees::ShowView.render(presenter), status: :ok
      end

      private

      def employee
        @employee ||= Employee.find_by(public_token: params[:id])
        raise ErrorResponderService.new(:record_not_found, 404) unless @employee

        @employee
      end
    end
  end
end
