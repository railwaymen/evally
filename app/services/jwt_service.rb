# frozen_string_literal: true

class JwtService
  DEFAULT_EXPIRATION_TIME = 12.hours

  def self.encode(id, exp = DEFAULT_EXPIRATION_TIME.from_now)
    JWT.encode({ id: id, exp: exp.to_i }, secret)
  end

  def self.decode(token)
    JWT.decode(token, secret).first
  end

  def self.secret
    Rails.application.credentials.secret_key_base
  end

  private_class_method :secret
end
