# frozen_string_literal: true

module V2
  module Dashboard
    class ShowView < Blueprinter::Base
      association :employees, blueprint: V2::Employees::Serializer, default: []

      association :drafts, blueprint: V2::Evaluations::EmployableSerializer, default: []

      association :activities, blueprint: V2::Activities::Serializer, default: []
    end
  end
end
