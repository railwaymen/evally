# frozen_string_literal: true

module V2
  module Views
    class TemplateView < Blueprinter::Base
      association :template, blueprint: V2::TemplateSerializer, default: {}

      association :sections, blueprint: V2::SectionSerializer, default: []
    end
  end
end
