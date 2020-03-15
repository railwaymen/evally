# frozen_string_literal: true

module V2
  module Comments
    class Serializer < Blueprinter::Base
      identifier :id

      fields :created_at

      field :body do |comment|
        if comment.discarded_at.blank?
          comment.body
        else
          I18n.t('activerecord.errors.messages.comment_deleted')
        end
      end

      field :user_fullname do |comment|
        comment.user&.fullname
      end
    end
  end
end
