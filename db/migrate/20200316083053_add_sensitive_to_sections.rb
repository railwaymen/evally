class AddSensitiveToSections < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :sensitive, :boolean, null: false, default: false
  end
end
