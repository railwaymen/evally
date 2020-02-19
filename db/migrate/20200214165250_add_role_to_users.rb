class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, null: false, default: 'evaluator'

    add_index :users, :role

    User.update_all(role: 'admin')
  end
end
