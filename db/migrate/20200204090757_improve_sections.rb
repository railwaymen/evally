class ImproveSections < ActiveRecord::Migration[5.2]
  def up
    change_column_null :sections, :name, false

    change_column(
      :sections,
      :group,
      "varchar USING (
        CASE \"group\"
          WHEN 0 THEN 'rating'::varchar
          WHEN 10 THEN 'bool'::varchar
          ELSE 'text'::varchar
        END
      )",
      null: false
    )

    change_column(
      :sections,
      :width,
      "varchar USING (
        CASE width
          WHEN 0 THEN 'half'::varchar
          ELSE 'full'::varchar
        END
      )",
      null: false
    )

    change_column_default :sections, :position, 0
    change_column_null :sections, :sectionable_type, false
    change_column_null :sections, :sectionable_id, false
  end

  def down
    change_column_null :sections, :sectionable_id, true
    change_column_null :sections, :sectionable_type, true
    change_column_default :sections, :position, nil

    change_column(
      :sections,
      :width,
      "integer USING (
        CASE width
          WHEN 'half' THEN 0::integer
          ELSE 10::integer
        END
      )",
      null: true
    )

    change_column(
      :sections,
      :group,
      "integer USING (
        CASE \"group\"
          WHEN 'rating' THEN 0::integer
          WHEN 'bool' THEN 10::integer
          ELSE 20::integer
        END
      )",
      null: true
    )

    change_column_null :sections, :name, true
  end
end
