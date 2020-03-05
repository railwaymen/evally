class CreateRecruitmentDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :recruitment_documents do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :encrypted_email, null: false
      t.string :phone
      t.string :position, null: false
      t.string :group, null: false
      t.datetime :received_at, null: false
      t.string :source, null: false

      t.timestamps
    end

    add_index :recruitment_documents, :email, unique: true
    add_index :recruitment_documents, :encrypted_email
    add_index :recruitment_documents, :group
  end
end
