# frozen_string_literal: true

module V2
  module Evaluations
    class EmployableSerializer < Blueprinter::Base
      identifier :id

      fields :employee_id, :state, :template_name, :updated_at, :completed_at

      field :first_name do |ev, _options|
        ev.employee.first_name
      end

      field :last_name do |ev, _options|
        ev.employee.last_name
      end

      field :position do |ev, _options|
        ev.employee.position
      end

      field :hired_on do |ev, _options|
        ev.employee.hired_on
      end

      field :next_evaluation_on do |ev, _options|
        ev.employee.next_evaluation_on
      end
    end
  end
end
