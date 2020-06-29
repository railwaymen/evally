class ChangeUserReferenceInRecruits < ActiveRecord::Migration[6.0]
  def up
    add_column :recruits, :evaluator_token, :string

    Recruit.all.map do |recruit|
      next if recruit.evaluator_id.blank?

      user = User.find_by(id: recruit.evaluator_id)
      recruit.update(evaluator_token: user&.email_token)
    end

    remove_column :recruits, :evaluator_id
  end

  def down
    add_column :recruits, :evaluator_id, :integer

    User.all.map do |user|
      recruits = Recruit.find_by(evaluator_token: user.email_token)

      recruits.update_all(evaluator_id: user.id)
    end

    remove_column :recruits, :evaluator_token
  end
end
