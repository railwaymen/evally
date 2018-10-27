class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :employee, foreign_key: true
      t.integer :state, default: 0
      t.datetime :completed_at

      t.timestamps
    end
  end
end
