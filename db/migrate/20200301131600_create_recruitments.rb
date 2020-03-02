class CreateRecruitments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitments do |t|
      t.references :candidate, foreign_key: true, index: true
      t.string :status, null: false, default: 'fresh'
      t.string :group, null: false
      t.string :position, null: false
      t.datetime :received_at, null: false
      t.string :source
      t.string :phone
      t.jsonb :social_links

      t.timestamps
    end

    add_index :recruitments, :group
    add_index :recruitments, :status
  end
end
