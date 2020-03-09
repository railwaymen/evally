class AddDestinationToTemplates < ActiveRecord::Migration[6.0]
  def up
    add_column :templates, :destination, :string, null: false, default: 'employees'
    change_column_default :templates, :destination, nil
  end

  def down
    remove_column :templates, :destination
  end
end
