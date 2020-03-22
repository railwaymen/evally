# frozen_string_literal: true

module V2
  module Recruits
    class ShowView < Blueprinter::Base
      association :evaluations, blueprint: V2::Evaluations::RecruitableSerializer, default: []

      association :evaluation, blueprint: V2::Evaluations::RecruitableSerializer, default: {}

      association :sections, blueprint: V2::Sections::Serializer, default: []

      association :templates, blueprint: V2::Templates::Serializer, default: []
    end
  end
end
