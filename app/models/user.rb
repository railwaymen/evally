class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable

  has_many :activities, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :evaluations, through: :employees
  has_many :templates, dependent: :destroy

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
