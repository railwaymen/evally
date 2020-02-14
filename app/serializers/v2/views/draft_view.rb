# frozen_string_literal: true

module V2
  module Views
    class DraftView < Blueprinter::Base
      association :draft, blueprint: V2::EvaluationSerializer, default: {}

      association :sections, blueprint: V2::SectionSerializer, default: []
    end
  end
end
