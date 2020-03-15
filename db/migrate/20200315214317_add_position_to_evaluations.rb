class AddPositionToEvaluations < ActiveRecord::Migration[6.0]
  def up
    add_column :evaluations, :position, :string

    ActiveRecord::Base.transaction do
      Evaluation.all.each do |evaluation|
        positionable = evaluation.employee || evaluation.recruit&.recruit_documents&.last
        evaluation.update!(position: positionable&.position || 'Just Employee')
      end
    end

    change_column_null :evaluations, :position, false
  end

  def down
    remove_column :evaluations, :position, :string
  end
end
