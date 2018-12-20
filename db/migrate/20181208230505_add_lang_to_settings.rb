class AddLangToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :lang, :string, default: 'en'
  end
end
