# frozen_string_literal: true

class Employee < ApplicationRecord
  has_secure_token :public_token

  # Associations
  #
  belongs_to :evaluator, class_name: 'User', optional: true

  has_many :evaluations, as: :evaluable, dependent: :destroy
  has_many :position_changes, dependent: :destroy

  has_one :latest_evaluation, -> { completed.order(completed_at: :desc) },
          as: :evaluable, class_name: 'Evaluation', inverse_of: :evaluable

  # # Scopes
  #
  scope :by_group, proc { |val| where(group: val) if val.present? }
  scope :by_evaluator_id, proc { |val| where(evaluator_id: val) if val.present? }

  # # Enums
  #
  enum state: {
    hired: 'hired',
    experienced: 'experienced',
    released: 'released',
    archived: 'archived'
  }

  # # Validation
  #
  validates :first_name, :last_name, :position, :hired_on, :group, presence: true

  # # Methods
  #
  def fullname
    [first_name, last_name].join(' ').strip
  end
end
