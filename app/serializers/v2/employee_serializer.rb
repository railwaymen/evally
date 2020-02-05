# frozen_string_literal: true

module V2
  class EmployeeSerializer < Blueprinter::Base
    identifier :id

    fields :first_name, :last_name, :position, :group, :state, :hired_at, :next_evaluation_at,
           :public_token

    field :position_set_at do |employee|
      employee.position_set_at || employee.hired_at
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
