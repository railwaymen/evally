module V1
  class EmployeeSerializer < Blueprinter::Base
    identifier :id

    fields *%i[
      first_name
      last_name
      public_token
      position
      group
      state
      hired_at
      next_evaluation_at
      released_at
      skill
    ]

    field :position_set_at do |employee|
      employee.position_set_at || employee.hired_at
    end

    view :evaluated do
      association :latest_evaluation, name: :evaluation, blueprint: V1::EvaluationSerializer, default: {}
    end
  end
end
