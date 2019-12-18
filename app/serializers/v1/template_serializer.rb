# frozen_string_literal: true

module V1
  class TemplateSerializer < Blueprinter::Base
    identifier :id

    fields :name, :state

    association :sections, name: :sections_attributes, blueprint: V1::SectionSerializer, default: []
  end
end
