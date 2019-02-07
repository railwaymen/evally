module V1
  class EmployeesSkillsListProvider

    def self.call
      rating_skills = Section.rating.pluck(:skills).flatten.collect{ |skill| { name: skill['name'], group: 'rating' } }.uniq
      bool_skills = Section.bool.pluck(:skills).flatten.collect{ |skill| { name: skill['name'], group: 'bool' } }.uniq

      [
        { header: 'Rating' },
        *rating_skills,
        { divider: true },
        { header: 'True/false' },
        *bool_skills
      ] # Output form necessary for frontend purpose
    end
  end
end
