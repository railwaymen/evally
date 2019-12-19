# frozen_string_literal: true

module V2
  class EmployeeSerializer < Blueprinter::Base
    identifier :id

    fields :first_name, :last_name, :position, :group, :state, :hired_at, :next_evaluation_at
  end
end
