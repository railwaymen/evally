class AddTrackableToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_sign_in_ip, :string
    add_column :users, :last_sign_in_at, :datetime
  end
end
