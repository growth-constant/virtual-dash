source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
gem 'pg', '~> 0.18.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'devise', '~> 4.7', '>= 4.7.3'
# gem for oauth authentication with third parties
gem "omniauth", "~> 1.9"
# gem to authenticate with strava
gem "omniauth-strava", "~> 0.0.6"
# gem process haml files
gem "haml-rails", "~> 2.0"
# gem to install semantic ui into rails
gem "fomantic-ui-sass", "~> 2.8"
# gem to simplify forms
gem "simple_form", "~> 5.0"
# gem to add country select for forms

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '~> 1.6'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'database_cleaner', '~> 1.8', '>= 1.8.5'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'faker', '~> 2.15', '>= 2.15.1'
  # Adds support for Capybara system testing and selenium driver
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "country_select", "~> 4.0"

gem "strava-ruby-client", "~> 0.4.0"
