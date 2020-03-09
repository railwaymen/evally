# frozen_string_literal: true

module V2
  module Comments
    class Serializer < Blueprinter::Base
      identifier :id

      fields :created_at

      field :body do |comment|
        comment.discarded_at.blank? ? comment.body : 'Comment has been deleted'
      end

      field :user_fullname do |comment|
        comment.user&.fullname
      end
    end
  end
end
