class RemoveStateFromTemplates < ActiveRecord::Migration[5.2]
  def up
    remove_column :templates, :state
  end

  def down
    add_column :templates, :state, :integer, default: 0
  end
end
