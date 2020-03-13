# frozen_string_literal: true

module V2
  module Employees
    class ShowView < Blueprinter::Base
      association :employee, blueprint: V2::Employees::Serializer, default: {}

      association :evaluations, blueprint: V2::Evaluations::EmployableSerializer, default: []

      association :position_changes, blueprint: V2::PositionChanges::Serializer, default: []
    end
  end
end
