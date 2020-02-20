# frozen_string_literal: true

module V2
  class EmployeeSerializer < Blueprinter::Base
    identifier :id

    fields :first_name, :last_name, :position, :group, :state, :hired_on, :next_evaluation_on,
           :public_token, :evaluator_id

    field :archived_at do |employee|
      employee.archived_at&.to_date
    end

    field :position_set_on do |employee|
      employee.position_set_on || employee.hired_on
    end

    field :evaluator_fullname do |employee|
      employee.evaluator&.fullname
    end

    field :latest_evaluation_date do |employee|
      employee.respond_to?(:latest_evaluation_date) ? employee.latest_evaluation_date : nil
    end

    view :search do
      field :skill do |employee|
        { group: employee.attributes['skill_group'] }.merge(employee.attributes.fetch('skill', {}))
      end
    end
  end
end
