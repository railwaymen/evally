# frozen_string_literal: true

set :deploy_to, ENV['CAP_PRODUCTION_DEPLOY_TO']
server ENV['CAP_PRODUCTION_SERVER'], user: ENV['CAP_PRODUCTION_SSH_USER'], roles: %w[app db web]
set :rvm_ruby_version, 'ruby-2.7.0'
