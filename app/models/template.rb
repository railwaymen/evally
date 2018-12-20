class Template < ApplicationRecord
  # include AASM

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
    message: :invalid_inclusion
  }

end
