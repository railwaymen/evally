# frozen_string_literal: true

module V2
  module Recruits
    class ShowView < Blueprinter::Base
      association :evaluators, blueprint: V2::Users::Serializer, default: []

      association :evaluations, blueprint: V2::Evaluations::RecruitableSerializer, default: []

      association :evaluation, blueprint: V2::Evaluations::RecruitableSerializer, default: {}

      association :sections, blueprint: V2::Sections::Serializer, default: []

      association :templates, blueprint: V2::Templates::Serializer, default: []

      association :comments, blueprint: V2::Comments::Serializer, default: []
    end
  end
end
