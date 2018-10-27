class Section < ApplicationRecord
  belongs_to :sectionable, polymorphic: true

  # # Enums

  enum group: { rating: 0, bool: 10, text: 20 }
  enum width: { half: 0, full: 1 }

  # # Validation

  validates :name, presence: true

  validates :group, presence: true, inclusion: {
    in: Section.groups.keys,
    message: "'%{value}' is not a valid group"
  }

  validates :width, presence: true, inclusion: {
    in: Section.widths.keys,
    message: "'%{value}' is not a valid width"
  }

  validates :position, presence: true, numericality: { only_integer: true }

  validate :skills_format, unless: Proc.new { |section| section.skills.blank? }

  private

    def skills_format
      if skills.is_a?(Array)
        all_skills_valid = skills.all? { |s| s.key?('name') && s.key?('value') }
        errors.add(:skills, 'must have name and value') unless all_skills_valid
      else
        errors.add(:skills, 'must be an Array of skills')
      end
    end
end
