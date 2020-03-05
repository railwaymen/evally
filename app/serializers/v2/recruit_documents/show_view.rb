# frozen_string_literal: true

module V2
  module RecruitDocuments
    class ShowView < Blueprinter::Base
      association :recruit_document, blueprint: V2::RecruitDocuments::Serializer, default: {}
    end
  end
end
