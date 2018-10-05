class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.datetime :hired_at
      t.datetime :last_evaluation_at
      t.datetime :next_evaluation_at
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :employees, :last_name
  end
end
