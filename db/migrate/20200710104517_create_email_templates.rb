class CreateEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :email_templates do |t|
      t.string :name, null: false
      t.string :subject, null: false
      t.text :body, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
