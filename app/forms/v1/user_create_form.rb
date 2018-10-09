module V1
  class UserCreateForm < ApplicationForm

    FIELDS = ['email', 'password', 'first_name', 'last_name'].freeze
    attr_accessor *FIELDS


    # # Validation
    #
    validates :email,
      presence: true,
      format: { with: RailsJwtAuth.email_regex, message: 'has invalid format' }

    validate :email_uniqueness

    validates :password,
      presence: true,
      length: { in: 6..32 }


    private

    def email_uniqueness
      emails = User.pluck(:email)

      if email.present? && emails.any?{ |e| e.downcase == email.downcase }
        errors.add(:email, 'is already taken')
      end
    end
  end
end
