namespace :skills do
  desc "Add needToImprove attribute to skills"
  
  task add_need_to_improve: :environment do
    
    Section.where(group: ['rating', 'bool']).each do |section|
      puts "Section no. #{section.id}"
      skills = section.skills.map { |skill| skill.merge({ needToImprove: false }) if skill[:needToImprove].nil? }
      section.update!(skills: skills)
    end

  end
end