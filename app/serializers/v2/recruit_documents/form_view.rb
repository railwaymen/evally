# frozen_string_literal: true

module V2
  module RecruitDocuments
    class FormView < Blueprinter::Base
      association :evaluators, blueprint: V2::Users::Serializer, default: []

      fields :groups, :positions, :statuses
    end
  end
end
