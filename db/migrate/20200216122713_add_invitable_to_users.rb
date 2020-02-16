class AddInvitableToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_column :users, :invitation_created_at, :datetime

    add_index :users, :invitation_token

    change_column_null :users, :email, false
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
  end
end
