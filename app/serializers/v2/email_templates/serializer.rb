# frozen_string_literal: true

module V2
  module EmailTemplates
    class Serializer < Blueprinter::Base
      identifier :id

      fields :name, :subject, :body, :creator_id

      field :creator_fullname do |template|
        template.creator&.fullname
      end
    end
  end
end
