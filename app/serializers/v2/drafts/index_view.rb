# frozen_string_literal: true

module V2
  module Drafts
    class IndexView < Blueprinter::Base
      association :drafts, blueprint: V2::Evaluations::Serializer, default: []

      association :employees, blueprint: V2::Employees::Serializer, default: []

      association :templates, blueprint: V2::Templates::Serializer, default: []
    end
  end
end
