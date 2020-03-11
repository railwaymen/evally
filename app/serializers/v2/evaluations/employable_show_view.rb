# frozen_string_literal: true

module V2
  module Evaluations
    class EmployableShowView < Blueprinter::Base
      association :evaluation, blueprint: V2::Evaluations::EmployableSerializer, default: {}

      association :sections, blueprint: V2::Sections::Serializer, default: []
    end
  end
end
