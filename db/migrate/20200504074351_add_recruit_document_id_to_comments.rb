class AddRecruitDocumentIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :recruit_document_id, :integer, null: false
  end
end
