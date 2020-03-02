# frozen_string_literal: true

module V2
  module Sections
    class Serializer < Blueprinter::Base
      identifier :id

      fields :name, :group, :width, :position, :skills
    end
  end
end
