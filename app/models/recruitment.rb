# frozen_string_literal: true

class Recruitment < ApplicationRecord
  belongs_to :candidate

  # # Scopes
  #
  scope :by_group, proc { |val| where(group: val) if val.present? }
  scope :by_status, proc { |val| where(status: val) if val.present? }

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
