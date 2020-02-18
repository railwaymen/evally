class RenameUserReferenceInTemplates < ActiveRecord::Migration[5.2]
  def change
    rename_column :templates, :user_id, :creator_id

    change_column_null :templates, :name, false
  end
end
