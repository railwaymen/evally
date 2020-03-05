class CreateRecruits < ActiveRecord::Migration[6.0]
  def change
    create_table :recruits do |t|
      t.string :external_id, null: false
      t.references :evaluator, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :recruits, :external_id, unique: true
  end
end
