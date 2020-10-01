class AddSignatureToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :signature, :text
  end
end
