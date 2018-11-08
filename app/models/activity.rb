class Activity < ApplicationRecord

  # # Associations
  #
  belongs_to :activable, polymorphic: true
  belongs_to :user

  # # Methods
  #
  def title
    I18n.translate("activities.#{activable_type.downcase}.#{action}.title")
  end

  def description
    I18n.translate("activities.#{activable_type.downcase}.#{action}.description", name: activable_name)
  end
end
