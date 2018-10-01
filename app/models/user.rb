class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  has_many :employees
  has_many :evaluation_templates
end
