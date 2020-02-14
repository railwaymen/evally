# frozen_string_literal: true

module V2
  class UserSerializer < Blueprinter::Base
    fields :email, :first_name, :last_name
  end
end
