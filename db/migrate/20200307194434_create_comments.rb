class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :recruit, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body, null: false
      t.string :created_by, null: false, default: 'human'
      t.datetime :discarded_at

      t.timestamps
    end
  end
end
