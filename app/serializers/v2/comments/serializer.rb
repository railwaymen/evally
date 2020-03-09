# frozen_string_literal: true

module V2
  module Comments
    class Serializer < Blueprinter::Base
      identifier :id

      fields :body, :created_at

      field :user_fullname do |comment|
        comment.user&.fullname
      end
    end
  end
end
