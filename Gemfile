source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record in non-production environments
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'

# Assets
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# The Rest of the gems
gem 'active_model_serializers', '~> 0.10.0'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'acts_as_votable', '~> 0.10.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'devise'
# Load environment variables from .env into ENV
gem 'dotenv-rails'
# Mail Chimp Gem
gem 'gibbon'
gem 'httparty'
gem 'httpclient', '~> 2.8', '>= 2.8.3'
gem 'impressionist'
gem 'jbuilder', '~> 2.5'
gem 'jwt'
gem 'oj', '~> 2.18.0'
gem 'oj_mimic_json'
gem 'rack-cors', :require => 'rack/cors'
gem 'rails_admin', '~> 1.0'
# SendGrid For Mailr
gem 'sendgrid-rails', '~> 2.0'
gem 'simple_command'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
