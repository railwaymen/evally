# frozen_string_literal: true

module V2
  module Templates
    class IndexView < Blueprinter::Base
      association :templates, blueprint: V2::Templates::Serializer, default: []

      fields :destinations
    end
  end
end
