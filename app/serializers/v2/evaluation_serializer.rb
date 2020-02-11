# frozen_string_literal: true

module V2
  class EvaluationSerializer < Blueprinter::Base
    identifier :id

    fields :state, :template_name, :updated_at, :employee_id, :completed_at

    field :employee_first_name do |ev, _options|
      ev.employee.first_name
    end

    field :employee_last_name do |ev, _options|
      ev.employee.last_name
    end

    field :employee_position do |ev, _options|
      ev.employee.position
    end

    field :employee_hired_on do |ev, _options|
      ev.employee.hired_on
    end

    field :next_evaluation_at do |ev, _options|
      ev.employee.next_evaluation_at
    end
  end
end
