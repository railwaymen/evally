# frozen_string_literal: true

class RecruitDocument < HumanResourcesRecord
  attr_readonly :encrypted_email

  # # Associations
  #
  belongs_to :recruit, primary_key: 'human_resources_id', foreign_key: 'encrypted_email',
                       inverse_of: :recruit_documents, optional: true

  # # Scopes
  #
  scope :by_group, proc { |val| where(group: val) if val.present? }
  scope :by_status, proc { |val| where(status: val) if val.present? }

  # # Validations
  #
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :first_name, :last_name, :position, :group, :received_at, :source, :encrypted_email,
            :status, presence: true

  # # Enums
  #
  enum status: {
    fresh: 'fresh',
    accepted: 'accepted',
    rejected: 'rejected'
  }

  # # Callbacks
  #
  before_validation :encrypt_email

  private

  def encrypt_email
    self.encrypted_email = email.present? ? Digest::SHA512.hexdigest(email) : nil
  end
end
