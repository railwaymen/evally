class Activity < ApplicationRecord

  # # Associations
  #
  belongs_to :activable, polymorphic: true
  belongs_to :user

  # # Scopes
  #
  scope :since, Proc.new { |date| where('DATE(created_at) >= ?', date) if date.present? }
  scope :to, Proc.new { |date| where('DATE(created_at) <= ?', date) if date.present? }

  # # Methods
  #
  def title
    I18n.translate("activities.#{activable_type.downcase}.#{action}.title")
  end

  def description
    I18n.translate("activities.#{activable_type.downcase}.#{action}.description", name: activable_name)
  end
end
