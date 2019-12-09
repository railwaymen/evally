class CreatePositionChanges < ActiveRecord::Migration[5.2]
  def change
    create_table :position_changes do |t|
      t.string :previous_position, null: false
      t.string :current_position, null: false
      t.date :changed_at, null: false

      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
