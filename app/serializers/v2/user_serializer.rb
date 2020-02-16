# frozen_string_literal: true

module V2
  class UserSerializer < Blueprinter::Base
    identifier :id

    fields :email, :first_name, :last_name, :role, :status, :last_sign_in_at,
           :invitation_accepted_at
  end
end
