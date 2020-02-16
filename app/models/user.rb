# frozen_string_literal: true

class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable
  include RailsJwtAuth::Invitable
  include RailsJwtAuth::Trackable

  has_one :setting, dependent: :destroy

  has_many :activities, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :evaluations, through: :employees
  has_many :templates, dependent: :destroy

  # # Validation
  #
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :password, presence: true, length: { in: 6..32 }, if: ->(u) { u.password.present? }

  validates :first_name, :last_name, :role, :status, presence: true

  # # Callbacks
  #
  after_create :create_setting

  # # Enums
  #
  enum role: { admin: 'admin', evaluator: 'evaluator' }
  enum status: { active: 'active', inactive: 'inactive' }

  # # Methods
  #
  def fullname
    [first_name, last_name].join(' ').strip
  end

  def authentication?(pass)
    # Override to allow only active users to be authenticated

    active? && authenticate(pass)
  end
end
