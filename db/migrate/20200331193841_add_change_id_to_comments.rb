class AddChangeIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :change_id, :integer
  end
end
