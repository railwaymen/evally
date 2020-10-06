# frozen_string_literal: true

module V2
  module Comments
    class Serializer < Blueprinter::Base
      identifier :id

      fields :user_id, :title, :created_at

      field :body do |comment|
        if comment.discarded_at.blank?
          comment.body
        else
          I18n.t('activerecord.errors.messages.comment_deleted')
        end
      end

      field :editable do |comment|
        comment.user.present? && comment.created_recently? && comment.created_by_human?
      end
    end
  end
end
