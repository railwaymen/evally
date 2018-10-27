class Template < ApplicationRecord
  include AASM

  # # Associations
  #
  belongs_to :user

  has_many :sections, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :sections, allow_destroy: true

  # # Enums
  #
  enum state: { draft: 0, enabled: 10, disabled: 20, removed: 30 }

  # # Validation
  #
  validates :name, presence: true

  validates :state, presence: true, inclusion: {
    in: Template.states.keys,
    message: "'%{value}' is not a valid state"
  }

  # # States
  #
  aasm column: :state, enum: true do
    state :draft, :initial => true
    state :enabled
    state :disabled
    state :removed

    event :enable do
      transitions from: [:draft, :disabled], to: :enable
    end

    event :disable do
      transitions from: :enabled, to: :disabled
    end

    event :remove do
      transitions from: [:draft, :enabled, :disabled], to: :removed
    end
  end

end
