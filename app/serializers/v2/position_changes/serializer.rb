# frozen_string_literal: true

module V2
  module PositionChanges
    class Serializer < Blueprinter::Base
      identifier :id

      fields :previous_position, :current_position, :changed_on
    end
  end
end
