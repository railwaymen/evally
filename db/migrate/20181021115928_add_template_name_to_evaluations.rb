class AddTemplateNameToEvaluations < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluations, :template_name, :string
  end
end
