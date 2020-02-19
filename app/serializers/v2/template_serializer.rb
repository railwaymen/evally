# frozen_string_literal: true

module V2
  class TemplateSerializer < Blueprinter::Base
    identifier :id

    fields :name, :creator_id

    field :creator_fullname do |template|
      template.creator&.fullname
    end
  end
end
