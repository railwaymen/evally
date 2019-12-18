# frozen_string_literal: true

module V1
  class EvaluationSerializer < Blueprinter::Base
    identifier :id

    fields :state, :completed_at, :template_name, :updated_at

    association :employee, blueprint: V1::EmployeeSerializer, default: {}
    association :sections, name: :sections_attributes, blueprint: V1::SectionSerializer, default: []
  end
end
