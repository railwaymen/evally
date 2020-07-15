# frozen_string_literal: true

module V2
  module Employees
    class Serializer < Blueprinter::Base
      identifier :id

      fields :first_name, :last_name, :position, :group, :state, :hired_on, :next_evaluation_on,
             :public_token, :evaluator_id, :archived_on, :last_evaluation_on

      field :position_set_on do |employee|
        employee.position_set_on || employee.hired_on
      end

      field :evaluator_fullname do |employee|
        employee.evaluator&.fullname
      end

      field :evaluation_exists do |employee|
        employee.respond_to?(:evaluation_exists) ? employee.evaluation_exists : nil
      end

      field :evaluated do |employee|
        employee.respond_to?(:evaluated) ? employee.evaluated : nil
      end

      view :search do
        field :skill do |employee|
          {
            group: employee.attributes['skill_group']
          }.merge(employee.attributes.fetch('skill', {}))
        end
      end
    end
  end
end
