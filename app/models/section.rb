# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :sectionable, polymorphic: true

  # # Enums

  enum group: { rating: 0, bool: 10, text: 20 }
  enum width: { half: 0, full: 1 }

  # # Validation

  validates :name, presence: true

  validates :group, presence: true, inclusion: {
    in: Section.groups.keys,
    message: :invalid_inclusion
  }

  validates :width, presence: true, inclusion: {
    in: Section.widths.keys,
    message: :invalid_inclusion
  }

  validates :position, presence: true, numericality: { only_integer: true }

  validate :skills_format, unless: proc { |section| section.skills.blank? }

  # # Scopes
  default_scope { order(position: :asc) }

  private

  def skills_format
    if skills.is_a?(Array)
      all_skills_valid = skills.all? { |s| s.key?('name') && s.key?('value') }
      errors.add(:skills, :name_and_value) unless all_skills_valid
    else
      errors.add(:skills, :skills_array)
    end
  end
end
