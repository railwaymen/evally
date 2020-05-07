# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are: :registerable,
  # :confirmable, :lockable, :timeoutable and :omniauthable, :rememberable
  devise :database_authenticatable, :recoverable, :validatable, :trackable, :invitable

  has_one :setting, dependent: :destroy

  has_many :activities, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id, inverse_of: :recipient, dependent: :destroy

  has_many :comments, dependent: :nullify
  has_many :employees, foreign_key: :evaluator_id, inverse_of: :evaluator, dependent: :nullify
  has_many :recruits, foreign_key: :evaluator_id, inverse_of: :evaluator, dependent: :nullify
  has_many :templates, foreign_key: :creator_id, inverse_of: :creator, dependent: :nullify

  # # Scopes
  #
  scope :active_admin_other_than, ->(id) { active.admin.where.not(id: id) }
  scope :active_recruiter_other_than, ->(id) { active.recruiter.where.not(id: id) }

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
  enum role: { admin: 'admin', evaluator: 'evaluator', recruiter: 'recruiter' }
  enum status: { active: 'active', inactive: 'inactive' }

  # # Methods
  #

  def fullname
    [first_name, last_name].join(' ').strip
  end

  def invitation_status
    return 'pending' if invitation_token.present?
    return 'accepted' if invitation_accepted_at.present?
  end

  def active_for_authentication?
    # Override to allow only active users to be authenticated

    active? && super
  end
end
