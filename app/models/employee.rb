# frozen_string_literal: true

class Employee < ApplicationRecord
  has_secure_token :public_token

  belongs_to :user
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
  enum state: { hired: 'hired', experienced: 'experienced', released: 'released' }

  # # Validation
  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :position, presence: true

  validates :hired_at, presence: true

  attr_accessor :skill

  # # Methods
  #
  def fullname
    [first_name, last_name].join(' ').strip
  end
end
