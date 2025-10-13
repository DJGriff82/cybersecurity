source "https://rubygems.org"

gem "rails", "~> 8.0.2", ">= 8.0.2.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

#custom gems
gem 'devise', '~> 4.9', '>= 4.9.4'


gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false



group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "pundit", "~> 2.5"
gem "acts_as_tenant", "~> 1.0"
gem "chartkick", "~> 5.2"
gem "groupdate", "~> 6.7"
gem "sidekiq", "~> 8.0"
gem "redis-rails", "~> 0.0.0"
gem "simple_form", "~> 5.3"

gem "rspec-rails", "~> 8.0", groups: [:development, :test]
gem "factory_bot_rails", "~> 6.5", groups: [:development, :test]
