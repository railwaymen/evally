# frozen_string_literal: true

class Comment < ApplicationRecord
  # # Associations
  #
  belongs_to :recruit, inverse_of: :comments
  belongs_to :user, optional: true

  # # Validations
  #
  validates :body, :created_by, presence: true
  validates :user_id, presence: true, if: :created_by_human?

  # # Enums
  #
  enum created_by: { human: 'human', bot: 'bot' }, _prefix: true

  # # Mathods
  #
  delegate :evaluator, to: :recruit

  def created_recently?
    discarded_at.blank? && created_at > 15.minutes.ago
  end

  def notifiable_path
    "/app/recruitments/#{recruit.public_recruit_id}/documents/#{recruit_document_id}"
  end
end
