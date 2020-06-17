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
    scope: %i[state],
    message: :draft_evaluation_exists
  }, if: -> { draft? && employee_type? }

  validates :position, presence: true
  validates :recruit_document_id, presence: true, if: :recruit_type?
  validates :state, inclusion: { in: Evaluation.states.keys, message: :invalid_inclusion }

  # # Methods
  #
  delegate :evaluator, to: :evaluable

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

  def notifiable_path
    if employee_type? && draft?
      "/app/evaluations/#{id}"
    elsif employee_type? && completed?
      "/app/employees/#{employee_id}/evaluations/#{id}"
    elsif recruit_type?
      "/app/recruitments/#{recruit.public_recruit_id}/documents/#{recruit_document_id}"
    end
  end
end
