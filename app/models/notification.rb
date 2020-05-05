# frozen_string_literal: true

class Notification < ApplicationRecord
  # # Associations
  #
  belongs_to :recipient, class_name: 'User', optional: true
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  # # Validations
  #
  validates :action, presence: true

  # # Methods
  #

  def body
    I18n.t(
      "notifications.#{notifiable_type.downcase}.#{action}",
      notifiable_name: resolve_notifiable_name,
      actor_name: actor.fullname
    )
  end

  def notifiable_path
    notifiable.notifiable_path if notifiable.present?
  end

  def unread
    read_at.blank?
  end

  private

  def resolve_notifiable_name
    if %w[Employee].include?(notifiable_type)
      notifiable.fullname
    elsif %w[Evaluation].include?(notifiable_type) && notifiable.employee_type?
      notifiable.employee.fullname
    else
      nil
    end
  end
end
