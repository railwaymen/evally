class RenameHumanResourcesColumnInRecruits < ActiveRecord::Migration[6.0]
  def change
    rename_column :recruits, :human_resources_id, :public_recruit_id
  end
end
