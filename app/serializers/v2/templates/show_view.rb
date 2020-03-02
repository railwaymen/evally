# frozen_string_literal: true

module V2
  module Templates
    class ShowView < Blueprinter::Base
      association :template, blueprint: V2::Templates::Serializer, default: {}

      association :sections, blueprint: V2::Sections::Serializer, default: []
    end
  end
end
