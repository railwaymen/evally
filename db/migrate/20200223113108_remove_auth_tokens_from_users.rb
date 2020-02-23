class RemoveAuthTokensFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :auth_tokens, :string
  end
end
