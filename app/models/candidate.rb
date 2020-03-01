# frozen_string_literal: true

class Candidate < ApplicationRecord
  belongs_to :evaluator, class_name: 'User', optional: true

  has_many :enrollments, dependent: :restrict_with_error

  # # Validations
  #
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :first_name, :last_name, presence: true
end
