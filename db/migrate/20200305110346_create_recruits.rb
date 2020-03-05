class CreateRecruits < ActiveRecord::Migration[6.0]
  def change
    create_table :recruits do |t|
      t.string :human_resources_id, null: false
      t.references :evaluator, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :recruits, :human_resources_id, unique: true
  end
end
