# frozen_string_literal: true

class Evaluation < ApplicationRecord
  # # Associations
  #
  belongs_to :evaluable, polymorphic: true

  has_many :sections, as: :sectionable, dependent: :destroy
  accepts_nested_attributes_for :sections

  # # Scopes
  #
  scope :employable, -> { where(evaluable_type: 'Employee') }
  scope :recruitable, -> { where(evaluable_type: 'Recruit') }

  # # Enums
  #
  enum state: { draft: 'draft', completed: 'completed', archived: 'archived' }

  # # Validations
  #
  validates :evaluable_id, uniqueness: {
    scope: %i[state evaluable_type],
    message: :draft_evaluation_exists
  }, if: :draft?

  validates :state, inclusion: { in: Evaluation.states.keys, message: :invalid_inclusion }

  # # Methods
  #
  def employee_type?
    evaluable_type == 'Employee'
  end

  def employee_id
    evaluable_id if employee_type?
  end

  def employee
    evaluable if employee_type?
  end

  def recruit_type?
    evaluable_type == 'Recruit'
  end

  def recruit_id
    evaluable_id if recruit_type?
  end

  def recruit
    evaluable if recruit_type?
  end
end
