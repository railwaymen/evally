class RemoveUnnecessaryColumns < ActiveRecord::Migration[5.2]
  def up
    change_table :employees do |t|
      t.remove :last_evaluation_at
    end

    change_table :templates do |t|
      t.remove :evaluations_count
    end
  end

  def down
    change_table :employees do |t|
      t.datetime :last_evaluation_at
    end

    change_table :templates do |t|
      t.integer :evaluations_count, default: 0
    end
  end
end
