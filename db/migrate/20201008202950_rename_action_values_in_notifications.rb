class RenameActionValuesInNotifications < ActiveRecord::Migration[6.0]
  def up
    Notification.where(action: :add_comment).update_all(action: :new_comment)
  end
end
