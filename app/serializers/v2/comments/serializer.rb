# frozen_string_literal: true

module V2
  module Comments
    class Serializer < Blueprinter::Base
      identifier :id

      fields :user_id, :created_at

      field :body do |comment|
        if comment.discarded_at.blank?
          comment.body
        else
          I18n.t('activerecord.errors.messages.comment_deleted')
        end
      end

      field :created_by do |comment|
        comment.user&.fullname || 'Bot'
      end

      field :editable do |comment|
        comment.user.present? && comment.created_recently?
      end
    end
  end
end
