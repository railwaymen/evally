# frozen_string_literal: true

module V2
  class EvaluationsQuery
    def self.call(scope = Evaluation.all)
      scope.select(fields).joins(:employee)
    end

    def self.fields # rubocop:disable Metrics/MethodLength
      [
        'evaluations.*',
        'employees.first_name AS employee_first_name',
        'employees.last_name AS employee_last_name',
        'employees.position AS employee_position',
        'employees.next_evaluation_at'
      ].join(', ')
    end

    private_class_method :fields
  end
end
