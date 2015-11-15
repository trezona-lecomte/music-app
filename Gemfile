source 'https://rubygems.org'

gem 'rails', github: "rails/rails"
gem 'sprockets-rails', github: "rails/sprockets-rails"
gem 'sprockets', github: "rails/sprockets"
gem 'sass-rails', github: "rails/sass-rails"
gem 'arel', github: "rails/arel"
gem 'rack', github: "rack/rack"

gem 'pg', '~> 0.18'
gem 'puma'
gem 'rack-cors', require: 'rack/cors'
gem 'active_model_serializers', '~> 0.10.0.rc2'

# gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'faker'
end

group :development do
  gem 'spring'
  # Loading the listen gem enables an evented file system monitor. Check
  # https://github.com/guard/listen#listen-adapters if on Windows or *BSD.
  # gem 'listen', '~> 3.0.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
