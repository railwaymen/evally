# frozen_string_literal: true

module V2
  class ActivitySerializer < Blueprinter::Base
    identifier :id

    fields :title, :description, :created_at
  end
end
