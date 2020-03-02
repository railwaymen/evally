# frozen_string_literal: true

module V2
  module Evaluations
    class ShowView < Blueprinter::Base
      association :evaluation, blueprint: V2::Evaluations::Serializer, default: {}

      association :sections, blueprint: V2::Sections::Serializer, default: []
    end
  end
end
