RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schemas_directory = Rails.root.join('spec', 'schemas', 'v1')
    schema_path = File.join(schemas_directory, "#{schema}.json")
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end
