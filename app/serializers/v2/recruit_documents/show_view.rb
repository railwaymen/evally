# frozen_string_literal: true

module V2
  module RecruitDocuments
    class ShowView < Blueprinter::Base
      association :recruit_document, blueprint: V2::RecruitDocuments::Serializer, default: {}

      association :templates, blueprint: V2::Templates::Serializer, default: []
    end
  end
end
