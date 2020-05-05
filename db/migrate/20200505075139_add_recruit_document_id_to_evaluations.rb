class AddRecruitDocumentIdToEvaluations < ActiveRecord::Migration[6.0]
  def change
    add_column :evaluations, :recruit_document_id, :integer
  end
end
