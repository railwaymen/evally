# frozen_string_literal: true

module V2
  module RecruitDocuments
    class EditView < Blueprinter::Base
      association :recruit_document, blueprint: V2::RecruitDocuments::Serializer, default: {}
      association :evaluators, blueprint: V2::Users::Serializer, default: []

      fields :groups, :positions, :statuses
    end
  end
end
