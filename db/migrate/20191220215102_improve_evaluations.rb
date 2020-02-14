class ImproveEvaluations < ActiveRecord::Migration[5.2]
  def up
    change_column_default :evaluations, :state, nil

    change_column(
      :evaluations,
      :state,
      "varchar USING (
        CASE state
          WHEN 0 THEN 'draft'::varchar
          WHEN 10 THEN 'completed'::varchar
          ELSE 'archived'::varchar
        END
      )",
      null: false
    )

    change_column_default :evaluations, :state, 'draft'
    add_index :evaluations, :state
  end

  def down
    remove_index :evaluations, :state
    change_column_default :evaluations, :state, nil

    change_column(
      :evaluations,
      :state,
      "integer USING (
        CASE state
          WHEN 'draft' THEN 0::integer
          WHEN 'completed' THEN 10::integer
          ELSE 20::integer
        END
      )",
      null: false
    )

    change_column_default :evaluations, :state, 0
  end
end
