class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  has_many :employees
  has_many :evaluations, through: :employees
  has_many :templates

  # # Validation
  #
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: RailsJwtAuth.email_regex, message: 'has invalid format' }

  validates :password,
    presence: true,
    length: { in: 6..32 }
end
