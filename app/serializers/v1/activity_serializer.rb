# frozen_string_literal: true

module V1
  class ActivitySerializer < Blueprinter::Base
    fields :title, :description, :created_at
  end
end
