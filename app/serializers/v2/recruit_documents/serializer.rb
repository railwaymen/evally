# frozen_string_literal: true

module V2
  module RecruitDocuments
    class Serializer < Blueprinter::Base
      identifier :id

      fields :first_name, :last_name, :gender, :email, :phone, :group, :position, :source,
             :received_at, :status
    end
  end
end
