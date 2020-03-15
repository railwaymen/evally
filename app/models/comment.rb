# frozen_string_literal: true

class Comment < ApplicationRecord
  # # Associations
  #
  belongs_to :recruit
  belongs_to :user, optional: true

  # # Validations
  #
  validates :body, :created_by, presence: true
  validates :user_id, presence: true, if: :created_by_human?

  # # Enums
  #
  enum created_by: { human: 'human', bot: 'bot' }, _prefix: true
end
