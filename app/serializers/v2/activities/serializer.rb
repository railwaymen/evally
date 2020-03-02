# frozen_string_literal: true

module V2
  module Activities
    class Serializer < Blueprinter::Base
      identifier :id

      fields :title, :description, :created_at
    end
  end
end
