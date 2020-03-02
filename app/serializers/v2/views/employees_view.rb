# frozen_string_literal: true

module V2
  module Views
    class EmployeesView < Blueprinter::Base
      association :employees, blueprint: V2::EmployeeSerializer, default: []

      association :evaluators, blueprint: V2::Users::Serializer, default: []
    end
  end
end
