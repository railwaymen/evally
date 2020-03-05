# frozen_string_literal: true

class Recruit < ApplicationRecord
  # # Associations
  #
  belongs_to :evaluator, class_name: 'User', optional: true

  has_many :recruit_documents, foreign_key: 'encrypted_email', primary_key: 'external_id',
                               inverse_of: :recruit, dependent: :destroy

  # # Validation
  #
  validates :external_id, presence: true, uniqueness: true
end
