source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'thin'
gem 'jquery-rails'
gem "therubyracer"
gem 'slim'
gem 'slim-rails'
gem 'simple_form'
gem 'countries'
gem 'google-analytics-rails'
gem 'devise'
gem 'devise_oauth2_providable'
gem 'faker', :require => false
gem 'sass-rails',   '~> 3.2.3'
gem 'bootstrap-sass', '~> 2.3.0.0'
#gem 'aws-s3', '0.6.2', :require => 'aws/s3'
#gem 'best_in_place'
gem 'sprockets', '~> 2.0'
#gem 'pdfkit'
#gem 'phony_rails'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'ejs'
end

group :development, :staging, :production do
  gem 'pg'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'sqlite3'
  gem 'capybara', '2.0.3'
  gem 'guard-rspec'
#  gem 'launchy'
#  gem 'rb-inotify', :require => false
#  gem 'rb-fsevent', :require => false
#  gem 'rb-fchange', :require => false
#  gem 'terminal-notifier-guard'
#  gem 'growl'
  gem 'guard-rails-assets'
  gem 'guard-livereload', require: false
#  gem 'rb-fsevent', require: false
  gem 'rack-livereload'
  gem 'yajl-ruby'
  gem 'guard-bundler'
#  gem 'konacha'
  gem 'rails-erd'
end

group :development do
  gem 'better_errors'
#  gem 'binding_of_caller'
  gem 'debugger'
end

group :test do
#  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'capybara-webkit'
  gem 'capybara-screenshot', :require => false
end
