class AddEmailTokenToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :email_token, :string
    add_index :users, :email_token

    User.all.map(&:save!)

    change_column_null :users, :email_token, false
  end

  def down
    remove_column :users, :email_token
  end
end
