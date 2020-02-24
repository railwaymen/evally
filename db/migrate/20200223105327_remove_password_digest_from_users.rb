class RemovePasswordDigestFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :password_digest, :string
  end

  def down
    add_column :users, :password_digest, :string

    User.all.each { |u| u.update(password: SecureRandom.hex ) }
  end
end
