# frozen_string_literal: true

module V2
  module RecruitDocuments
    class IndexView < Blueprinter::Base
      association :recruit_documents, blueprint: V2::RecruitDocuments::Serializer, default: []

      fields :groups, :statuses
    end
  end
end
