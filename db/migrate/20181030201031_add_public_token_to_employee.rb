class AddPublicTokenToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :public_token, :string
    add_index :employees, :public_token, unique: true

    Employee.all.map(&:regenerate_public_token)
  end
end
