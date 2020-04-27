# frozen_string_literal: true

# :nocov:
class ApiClientService
  def initialize(user, base_url)
    @user = user
    @base_url = base_url
  end

  def post(url, params)
    connection.post(url) do |request|
      request.body = JSON.generate(params)
    end
  end

  private

  def connection
    @connection ||= Faraday.new(
      url: @base_url,
      headers: {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'Token' => JwtService.encode(@user)
      }
    )
  end
end
# :nocov:
