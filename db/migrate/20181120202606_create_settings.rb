class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.references :user, foreign_key: true
      t.integer :default_draft_items, default: 5
      t.integer :default_upcoming_items, default: 5
      t.integer :default_next_evaluation_time, default: 6 # months
      t.boolean :public_view_enabled, default: false

      t.timestamps
    end

    User.all.map { |user| Setting.create(user: user) }
  end
end
