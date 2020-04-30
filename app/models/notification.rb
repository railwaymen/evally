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
      notifiable: notifiable.fullname || notifiable_type.downcase,
      actor: actor.fullname
    )
  end

  def path
    I18n.t("notifications.#{notifiable_type.downcase}.path", id: notifiable_id)
  end
end
