# frozen_string_literal: true

module V2
  module Browse
    class EmployeesController < ApplicationController
      def show
        presenter = V2::EmployeePresenter.new(employee)

        render json: V2::Views::EmployeeView.render(presenter), status: :ok
      end

      private

      def employee
        @employee ||= Employee.find_by(public_token: params[:id])
        raise V1::ErrorResponderService.new(:record_not_found, 404) unless @employee

        @employee
      end
    end
  end
end
