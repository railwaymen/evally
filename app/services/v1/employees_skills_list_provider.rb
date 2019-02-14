module V1
  class EmployeesSkillsListProvider

    def self.call
      rating_skills = Section.rating.pluck(:skills).flatten.collect{ |skill| { name: skill['name'], group: 'rating' } }.uniq
      bool_skills = Section.bool.pluck(:skills).flatten.collect{ |skill| { name: skill['name'], group: 'bool' } }.uniq

      {
        rating: rating_skills,
        bool: bool_skills
      }
    end
  end
end
