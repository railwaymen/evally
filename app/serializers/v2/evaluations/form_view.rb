# frozen_string_literal: true

module V2
  module Evaluations
    class FormView < Blueprinter::Base
      association :employees, blueprint: V2::Employees::Serializer, default: []

      association :templates, blueprint: V2::Templates::Serializer, default: []
    end
  end
end
