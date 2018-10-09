class Template < ApplicationRecord
  include AASM

  # # Associations
  #
  belongs_to :user

  has_many :sections, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :sections, reject_if: :invalid_section?, allow_destroy: true

  # # States
  #
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

  private

  def invalid_section?(attributes)
    V1::SectionForm.new(Section.new, attributes).invalid?
  end
end
