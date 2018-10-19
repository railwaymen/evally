class Employee < ApplicationRecord
  belongs_to :user

  # # Validation
  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :position, presence: true

  validates :hired_at, presence: true
end
