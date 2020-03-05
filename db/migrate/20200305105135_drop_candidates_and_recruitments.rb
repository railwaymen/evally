class DropCandidatesAndRecruitments < ActiveRecord::Migration[6.0]
  def up
    drop_table :recruitments, if_exists: true
    drop_table :candidates, if_exists: true
  end

  def down; end
end
