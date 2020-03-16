# frozen_string_literal: true

class Recruit < ApplicationRecord
  # # Associations
  #
  belongs_to :evaluator, class_name: 'User', optional: true

  has_many :comments, dependent: :destroy
  has_many :evaluations, as: :evaluable, dependent: :destroy
  has_many :recruit_documents, foreign_key: 'encrypted_email', primary_key: 'human_resources_id',
                               inverse_of: :recruit, dependent: :destroy

  # # Validation
  #
  validates :human_resources_id, presence: true, uniqueness: true
end
