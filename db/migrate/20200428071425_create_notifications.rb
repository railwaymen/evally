class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :recipient, foreign_key: { to_table: :users }
      t.references :actor, null: false, foreign_key: { to_table: :users }
      t.datetime :read_at
      t.string :action, null: false
      t.references :notifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
