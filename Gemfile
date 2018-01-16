# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.4.0"

gem "administrate"
gem "autoprefixer-rails"
gem "clearance"
gem "delayed_job_active_record"
gem "flutie"
gem "honeybadger"
gem "http"
gem "jquery-rails"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 5.0"
gem "recipient_interceptor"
gem "rubocop"
gem "sass-rails"
gem "simple_form"
gem "skylight"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "suspenders"
gem "title"
gem "uglifier"
gem "yelp"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rails-controller-testing"
  gem "rspec-rails"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_stdout_logging"
end

gem "bourbon"
gem "high_voltage"
gem "neat"
gem "refills", group: %i(development test)
