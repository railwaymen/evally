# frozen_string_literal: true

module V2
  module Views
    class DraftsView < Blueprinter::Base
      association :drafts, blueprint: V2::EvaluationSerializer, default: []

      association :employees, blueprint: V2::EmployeeSerializer, default: []

      association :templates, blueprint: V2::Templates::Serializer, default: []
    end
  end
end
