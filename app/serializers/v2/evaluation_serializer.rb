# frozen_string_literal: true

module V2
  class EvaluationSerializer < Blueprinter::Base
    identifier :id

    fields :state, :template_name, :updated_at, :employee_id, :employee_first_name,
           :employee_last_name, :employee_position, :employee_hired_at, :next_evaluation_at
  end
end