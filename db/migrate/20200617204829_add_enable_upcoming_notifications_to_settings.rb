class AddEnableUpcomingNotificationsToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :enable_upcoming_notifications, :boolean, null: false, default: true

    change_column_null :settings, :default_draft_items, false
    change_column_null :settings, :default_upcoming_items, false
    change_column_null :settings, :default_next_evaluation_time, false
    change_column_null :settings, :lang, false
  end
end
