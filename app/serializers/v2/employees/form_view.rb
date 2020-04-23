# frozen_string_literal: true

module V2
  module Employees
    class FormView < Blueprinter::Base
      fields :positions, :groups

      association :evaluators, blueprint: V2::Users::Serializer, default: []
    end
  end
end
