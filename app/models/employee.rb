# frozen_string_literal: true

class Employee < ApplicationRecord
  has_secure_token :public_token

  belongs_to :evaluator, class_name: 'User', optional: true
  has_many :evaluations, dependent: :destroy
  has_many :position_changes, dependent: :destroy

  has_one :latest_evaluation, lambda {
    completed.order(completed_at: :desc)
  }, class_name: 'Evaluation', foreign_key: :employee_id, inverse_of: :employee

  # # Scopes
  #
  scope :by_state, proc { |state| where(state: state) if state.present? }

  # # Enums
  #
  enum state: { hired: 'hired', experienced: 'experienced', released: 'released',
                archived: 'archived' }

  # # Validation
  #
  validates :first_name, :last_name, :position, :hired_on, presence: true

  # # Methods
  #
  def fullname
    [first_name, last_name].join(' ').strip
  end
end
