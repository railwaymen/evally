# frozen_string_literal: true

module GeneralHelpers
  def stub_api_client_service(response: OpenStruct.new(status: 204))
    allow_any_instance_of(ApiClientService).to receive(:post).and_return(response)
  end
end

RSpec.configure do |config|
  config.include GeneralHelpers
end
