class Template < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :sections, as: :sectionable

  enum state: { draft: 0, enabled: 10, disabled: 20, removed: 30 }

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
