# frozen_string_literal: true

class Recruit < ApplicationRecord
  # # Associations
  #
  belongs_to :evaluator, class_name: 'User', optional: true, inverse_of: :recruits,
                         foreign_key: :evaluator_token, primary_key: :email_token

  has_many :comments, dependent: :destroy
  has_many :evaluations, as: :evaluable, dependent: :destroy

  # # Validation
  #
  validates :public_recruit_id, presence: true, uniqueness: true

  def notifiable_path
    '/app/recruitments'
  end
end
