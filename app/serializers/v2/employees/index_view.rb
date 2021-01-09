# frozen_string_literal: true

module V2
  module Employees
    class IndexView < Blueprinter::Base
      fields :groups, :total_count

      association :employees, blueprint: V2::Employees::Serializer, default: []

      association :evaluators, blueprint: V2::Users::Serializer, default: []
    end
  end
end
