class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  has_many :employees
end
