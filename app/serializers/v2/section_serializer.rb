# frozen_string_literal: true

module V2
  class SectionSerializer < Blueprinter::Base
    identifier :id

    fields :name, :group, :width, :position, :skills
  end
end
