class ImproveEmployees < ActiveRecord::Migration[5.2]
  def up
    change_column_default :employees, :state, nil

    change_column(
      :employees,
      :state,
      "varchar USING (
        CASE state
          WHEN 0 THEN 'hired'::varchar
          WHEN 10 THEN 'experience'::varchar
          ELSE 'released'::varchar
        END
      )",
      null: false
    )

    change_column_default :employees, :state, 'hired'
    add_index :employees, :state

    change_column_null :employees, :first_name, false
    change_column_null :employees, :last_name, false
    change_column_null :employees, :position, false
    change_column_null :employees, :hired_on, false
    change_column_null :employees, :public_token, false
    change_column_null :employees, :group, false
  end

  def down
    change_column_null :employees, :first_name, true
    change_column_null :employees, :last_name, true
    change_column_null :employees, :position, true
    change_column_null :employees, :hired_on, true
    change_column_null :employees, :public_token, true
    change_column_null :employees, :group, true

    remove_index :employees, :state
    change_column_default :employees, :state, nil

    change_column(
      :employees,
      :state,
      "integer USING (
        CASE state
          WHEN 'hired' THEN 0::integer
          WHEN 'experience' THEN 10::integer
          ELSE 20::integer
        END
      )",
      null: false
    )

    change_column_default :employees, :state, 0
  end
end
