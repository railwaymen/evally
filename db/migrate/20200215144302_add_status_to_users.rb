class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :string, null: false, default: 'active'
    add_index :users, :status
  end
end
