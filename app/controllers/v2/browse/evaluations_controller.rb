# frozen_string_literal: true

module V2
  module Browse
    class EvaluationsController < ApplicationController
      def show
        presenter = V2::Evaluations::ShowPresenter.new(evaluation)

        render json: V2::Evaluations::ShowView.render(presenter), status: :ok
      end

      private

      def employee
        @employee ||= Employee.find_by(public_token: params[:employee_id])
        raise ErrorResponderService.new(:record_not_found, 404) unless @employee

        @employee
      end

      def evaluation
        @evaluation ||= employee.evaluations.completed.find_by(id: params[:id])
        raise ErrorResponderService.new(:record_not_found, 404) unless @evaluation

        @evaluation
      end
    end
  end
end
