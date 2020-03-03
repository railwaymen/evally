# frozen_string_literal: true

module V2
  module Recruitments
    class ShowView < Blueprinter::Base
      association :recruitment, blueprint: V2::Recruitments::Serializer, default: {}
    end
  end
end
