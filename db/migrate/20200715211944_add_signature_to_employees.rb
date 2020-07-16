class AddSignatureToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :signature, :string
  end
end
