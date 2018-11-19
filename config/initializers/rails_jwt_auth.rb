RailsJwtAuth.setup do |config|
  # authentication model class name
  #config.model_name = 'User'

  # field name used to authentication with password
  #config.auth_field_name = 'email'

  # set to true to validate auth_field email format
  #config.auth_field_email = true

  # regex used to Validate email format
  #config.email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # expiration time for generated tokens
  config.jwt_expiration_time = 8.hours

  # the "iss" (issuer) claim identifies the principal that issued the JWT
  #config.jwt_issuer = 'RailsJwtAuth'

  # number of simultaneously sessions for an user
  config.simultaneous_sessions = 3

  # mailer sender
  #config.mailer_sender = 'initialize-mailer_sender@example.com'

  # url used to create email link with confirmation token
  #config.confirmation_url = 'http://frontend.com/confirmation'

  # expiration time for confirmation tokens
  #config.confirmation_expiration_time = 1.day

  # url used to create email link with reset password token
  #config.reset_password_url = 'http://frontend.com/reset_password'

  # url used to create email link with set password token
  # by set_and_send_password_instructions method
  #config.set_password_url = 'http://frontend.com/set_password'

  # expiration time for reset password tokens
  #config.reset_password_expiration_time = 1.day

  # uses deliver_later to send emails instead of deliver method
  #config.deliver_later = false

  # time an invitation is valid after sent
  # config.invitation_expiration_time = 2.days

  # url used to create email link with activation token parameter to accept invitation
  # config.accept_invitation_url = 'http://frontend.com/accept_invitation'
end


RailsJwtAuth::RenderHelper.module_eval do

  def render_session(jwt, user)
    render json: {
      session: {
        jwt: jwt,
        user: V1::UserSerializer.new(user).serializable_hash
      }
    }, status: 201
  end

end
