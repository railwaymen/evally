# frozen_string_literal: true

module V2
  class TemplateSerializer < Blueprinter::Base
    identifier :id

    fields :name
  end
end
