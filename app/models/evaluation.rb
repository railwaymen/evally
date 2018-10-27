class Evaluation < ApplicationRecord

  # # Associations
  #
  belongs_to :employee

  has_many :sections, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :sections

  # # Enums
  #
  enum state: { draft: 0, completed: 10 }

  # # Validations
  #
  validates :employee_id, uniqueness: {
    scope: :state,
    message: 'employee\'s draft evaluation already exists'
  }, if: :draft?

  validates :state, inclusion: {
    in: Evaluation.states.keys,
    message: "'%{value}' is not a valid state"
  }

end
