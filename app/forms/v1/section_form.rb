module V1
  class SectionForm < ApplicationForm

    FIELDS = ['name', 'group', 'width', 'position', 'skills', '_destroy'].freeze
    attr_accessor *FIELDS

    validates :name, presence: true

    validates :group, presence: true, inclusion: { in: Section.groups.keys}

    validates :width, presence: true, inclusion: { in: Section.widths.keys}

    validates :position, presence: true, numericality: { only_integer: true }

    validate :skills_format, unless: Proc.new { |section| section.skills.blank? }

    private

    def skills_format
      if skills.is_a?(Array)
        all_skills_valid = skills.all? { |skill| skill.key?('name') && skill.key?('value') }
        errors.add(:skills, 'must have name and value') unless all_skills_valid
      else
        errors.add(:skills, 'must be an Array of skills')
      end
    end

  end
end
