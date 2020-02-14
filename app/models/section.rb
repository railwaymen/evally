# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :sectionable, polymorphic: true

  # # Enums

  enum group: { rating: 'rating', bool: 'bool', text: 'text' }
  enum width: { half: 'half', full: 'full' }

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
