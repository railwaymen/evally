class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  has_many :employees
  has_many :templates
end
