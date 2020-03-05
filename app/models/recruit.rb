# frozen_string_literal: true

class Recruit < ApplicationRecord
  # # Associations
  #
  belongs_to :evaluator, class_name: 'User', optional: true

  has_many :recruitment_documents, foreign_key: 'encrypted_email', primary_key: 'external_id',
           dependent: :destroy

  # # Validation
  #
  validates :external_id, presence: true, uniqueness: true
end
