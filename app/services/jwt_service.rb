# frozen_string_literal: true

# :nocov:
class JwtService
  DEFAULT_EXPIRATION_TIME = 12.hours

  def self.encode(user, exp = DEFAULT_EXPIRATION_TIME.from_now)
    JWT.encode({ id: user.id, role: user.role, api_key: api_key, exp: exp.to_i }, secret)
  end

  def self.decode(token)
    JWT.decode(token, secret).first
  end

  def self.api_key
    Rails.application.credentials.evally.fetch(:api_key)
  end

  def self.secret
    Rails.application.credentials.secret_key_base
  end

  private_class_method :api_key, :secret
end
# :nocov:
