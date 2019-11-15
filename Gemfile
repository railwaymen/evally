source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 1.1', '>= 1.1.3'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'

# Middleware that will make Rack-based apps CORS compatible
gem 'rack-cors', '~> 1.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Framework for factories
  gem 'factory_bot_rails', '~> 4.11'

  # Provide fake data
  gem 'faker', '~> 1.9.1'

  # JSON schema validator
  gem 'json-schema', '~> 2.8'

  # An IRB alternative and runtime developer console
  gem 'pry', '~> 0.11.3'

  # Testing framework for Rails 3+.
  gem 'rspec-rails', '~> 3.8'

  # Set of matchers methods for TDD
  gem 'shoulda-matchers', '~> 3.1.2'

  # Code coverage analysis tool for Ruby
  gem 'simplecov', '~> 0.16.1'

  # Use sqlite3 as the database for Active Record
  # gem 'sqlite3'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-yarn'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# JSON Object Presenter for Ruby
gem 'blueprinter', '~> 0.12.0'

# JWT User Authentication
gem 'rails_jwt_auth', '~> 0.23.0'
