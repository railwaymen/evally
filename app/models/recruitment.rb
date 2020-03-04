# frozen_string_literal: true

class Recruitment < ApplicationRecord
  belongs_to :candidate

  # # Validation
  #
  validates :group, :position, :received_at, :status, presence: true

  # # Enums
  #
  enum status: {
    imported: 'imported',
    fresh: 'fresh',
    ongoing: 'ongoing',
    awaiting_response: 'awaiting_response',
    suspended: 'suspended',
    accepted: 'accepted',
    rejected: 'rejected'
  }
end
