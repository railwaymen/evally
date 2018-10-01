class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :name, index: true
      t.integer :group
      t.integer :width
      t.integer :position
      t.text :skills, array: true
      t.references :sectionable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
