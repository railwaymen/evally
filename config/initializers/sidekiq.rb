# frozen_string_literal: true

env = Rails.application.config.env
basename = Rails.root.basename.to_s

Sidekiq.configure_server do |config|
  config.redis = {
    url: env.fetch(:core).fetch(:redis).fetch(:url),
    namespace: Rails.env.development? ? basename : env.fetch(:core).fetch(:redis).fetch(:namespace)
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: env.fetch(:core).fetch(:redis).fetch(:url),
    namespace: Rails.env.development? ? basename : env.fetch(:core).fetch(:redis).fetch(:namespace)
  }
end
