# frozen_string_literal: true

require 'rails_jwt_auth/spec_helpers'

RSpec.configure do |config|
  config.include RailsJwtAuth::SpecHelpers, type: :controller
end
