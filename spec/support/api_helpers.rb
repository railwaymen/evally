# frozen_string_literal: true

module ApiHelpers
  def expect_success_api_response_for(resource)
    expect(response).to have_http_status 200
    expect(response.content_type).to eq 'application/json'
    expect(response).to match_response_schema(resource)
  end

  def expect_error_api_response(code)
    expect(response).to have_http_status code.to_i
    expect(response.content_type).to eq 'application/json'
    expect(response).to match_response_schema('error')
  end

  def json_response
    JSON.parse(response.body)
  end
end
