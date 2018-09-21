module V1
  class UserCreateForm < Reform::Form
    model :user

    property :email
    property :password
    property :first_name
    property :last_name

    validates_uniqueness_of :email

    validates :email,
      presence: true,
      format: { with: RailsJwtAuth.email_regex, message: 'has invalid format' }

    validates :password,
      presence: true,
      length: { in: 6..32 }

  end
end
