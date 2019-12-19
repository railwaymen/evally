# frozen_string_literal: true

module V2
  module Dashboard
    class DraftsQuery
      def self.call(scope = Evaluation.draft)
        scope.select(fields).joins(:employee)
      end

      def self.fields
        [
          'evaluations.id',
          'evaluations.state',
          'evaluations.updated_at',
          'employee_id',
          'employees.first_name AS employee_first_name',
          'employees.last_name AS employee_last_name',
          'employees.position AS employee_position',
          'employees.next_evaluation_at'
        ].join(', ')
      end

      private_class_method :fields
    end
  end
end
