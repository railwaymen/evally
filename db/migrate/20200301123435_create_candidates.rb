class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender
      t.references :evaluator, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end

    add_index :candidates, :email, unique: true
  end
end
