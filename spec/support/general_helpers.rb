# frozen_string_literal: true

module GeneralHelpers
  def stub_api_client_service(method: :post, response: OpenStruct.new(status: 204))
    allow_any_instance_of(ApiClientService).to receive(method).and_return(response)
  end
end

RSpec.configure do |config|
  config.include GeneralHelpers
end
