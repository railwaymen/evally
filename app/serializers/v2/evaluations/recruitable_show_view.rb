# frozen_string_literal: true

module V2
  module Evaluations
    class RecruitableShowView < Blueprinter::Base
      association :evaluation, blueprint: V2::Evaluations::RecruitableSerializer, default: {}

      association :sections, blueprint: V2::Sections::Serializer, default: []
    end
  end
end
