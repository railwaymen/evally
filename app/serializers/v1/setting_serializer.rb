# frozen_string_literal: true

module V1
  class SettingSerializer < Blueprinter::Base
    fields :default_draft_items, :default_upcoming_items, :default_next_evaluation_time,
           :public_view_enabled, :lang
  end
end
