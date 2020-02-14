# frozen_string_literal: true

class Activity < ApplicationRecord
  # # Associations
  #
  belongs_to :activable, polymorphic: true
  belongs_to :user

  # # Scopes
  #
  scope :since, proc { |date| where('DATE(created_at) >= ?', date) if date.present? }
  scope :to, proc { |date| where('DATE(created_at) <= ?', date) if date.present? }

  # # Methods
  #
  def title
    I18n.translate("activities.#{activable_type.downcase}.#{action}.title")
  end

  def description
    I18n.translate(
      "activities.#{activable_type.downcase}.#{action}.description",
      user: user.first_name,
      name: activable_name
    )
  end
end
