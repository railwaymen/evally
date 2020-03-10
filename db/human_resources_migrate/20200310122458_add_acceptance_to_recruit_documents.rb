class AddAcceptanceToRecruitDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :recruit_documents, :accept_current_process, :boolean, default: true
    add_column :recruit_documents, :accept_future_process, :boolean
  end
end
