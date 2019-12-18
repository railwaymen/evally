# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.3'
gem 'pg', '~> 1.1', '>= 1.1.3'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'rack-cors', '~> 1.0', '>= 1.0.2'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'blueprinter', '~> 0.12.0'
gem 'rails_jwt_auth', '~> 0.23.0'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', '~> 4.3.1', require: false
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.11'
  gem 'faker', '~> 1.9.1'
  gem 'json-schema', '~> 2.8'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'simplecov', '~> 0.16.1'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-yarn'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
