class CreateRecruitDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :recruit_documents do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender
      t.string :email, null: false
      t.string :encrypted_email, null: false
      t.string :phone
      t.string :position, null: false
      t.string :group, null: false
      t.datetime :received_at, null: false
      t.string :source, null: false
      t.string :status, null: false, default: 'fresh'

      t.timestamps
    end

    add_index :recruit_documents, :email, unique: true
    add_index :recruit_documents, :encrypted_email
    add_index :recruit_documents, :group
    add_index :recruit_documents, :status
  end
end
