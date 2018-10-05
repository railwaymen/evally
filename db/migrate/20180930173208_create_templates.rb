class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :name, unique: true
      t.integer :state, default: 0
      t.integer :evaluations_count, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :templates, :name
  end
end
