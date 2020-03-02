# frozen_string_literal: true

module V2
  module Settings
    class Serializer < Blueprinter::Base
      fields :default_draft_items, :default_upcoming_items, :default_next_evaluation_time, :lang
    end
  end
end
