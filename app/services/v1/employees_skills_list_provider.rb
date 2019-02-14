module V1
  class EmployeesSkillsListProvider

    def self.call
      rating_skills = Section.rating.pluck(:skills).flatten.collect{ |skill| skill['name'] }.uniq
      bool_skills = Section.bool.pluck(:skills).flatten.collect{ |skill| skill['name'] }.uniq

      { rating: rating_skills, bool: bool_skills }.to_json
    end
  end
end
