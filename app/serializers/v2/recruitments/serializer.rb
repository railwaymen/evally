# frozen_string_literal: true

module V2
  module Recruitments
    class Serializer < Blueprinter::Base
      identifier :id

      fields :candidate_id, :first_name, :last_name, :email, :phone, :social_links, :gender,
             :status, :group, :position, :source, :received_at
    end
  end
end
