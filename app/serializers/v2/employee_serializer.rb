# frozen_string_literal: true

module V2
  class EmployeeSerializer < Blueprinter::Base
    identifier :id

    fields :first_name, :last_name, :position, :group, :state, :hired_on, :next_evaluation_on,
           :public_token, :evaluator_id

    field :position_set_on do |employee|
      employee.position_set_on || employee.hired_on
    end

    view :index do
      fields :latest_evaluation_date
    end

    view :search do
      fields :latest_evaluation_date

      field :skill do |employee|
        { group: employee.attributes['skill_group'] }.merge(employee.attributes.fetch('skill', {}))
      end
    end
  end
end
