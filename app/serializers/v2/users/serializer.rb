# frozen_string_literal: true

module V2
  module Users
    class Serializer < Blueprinter::Base
      identifier :id

      fields :email, :first_name, :last_name, :role, :status, :last_sign_in_at, :invitation_status
    end
  end
end
