class ChangeSectionSkillsTypeToJsonb < ActiveRecord::Migration[5.2]
  # tip source: https://stackoverflow.com/a/36468768
  
  def up
    change_column :sections, :skills, 'jsonb USING CAST(skills AS jsonb)', default: []
  end

  def down
    change_column :sections, :skills, 'json USING CAST(skills AS json)', default: []
  end
end
