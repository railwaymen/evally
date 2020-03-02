# frozen_string_literal: true

module V2
  module Drafts
    class ShowView < Blueprinter::Base
      association :draft, blueprint: V2::Evaluations::Serializer, default: {}

      association :sections, blueprint: V2::Sections::Serializer, default: []
    end
  end
end
