class Employee < ApplicationRecord
  belongs_to :user
  has_many :evaluations, dependent: :destroy

  # # Validation
  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :position, presence: true

  validates :hired_at, presence: true
end
