# frozen_string_literal: true

module V2
  module Views
    class EmployeeView < Blueprinter::Base
      association :employee, blueprint: V2::EmployeeSerializer, default: {}

      association :evaluations, blueprint: V2::EvaluationSerializer, default: []

      association :position_changes, blueprint: V2::PositionChangeSerializer, default: []
    end
  end
end
