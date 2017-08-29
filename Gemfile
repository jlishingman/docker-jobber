source "https://rubygems.org"
# ruby "1.9.3", :engine => "jruby", :engine_version => "1.7.19"
# ruby "2.1.0", :engine => "rbx", :engine_version => "2.5.2"
ruby "2.3.4"

module ::Kernel
  def rails_next?
    ENV["RAILS_NEXT"]
  end
end

module Bundler::SharedHelpers
  def default_lockfile=(path)
    @default_lockfile = path
  end

  def default_lockfile
    @default_lockfile ||= Pathname.new("#{default_gemfile}.lock")
  end
end

# To test and develop against an upcoming rails upgrade, export RAILS_NEXT=1 in your environment.
# When updating gems, remember to update both gemfiles with:
#
#   bundle install && RAILS_NEXT=1 bundle install
#
# https://jobber.atlassian.net/wiki/display/JTW/The+Next+Rails
if rails_next?
  Bundler::SharedHelpers.default_lockfile = Pathname.new("#{Bundler::SharedHelpers.default_gemfile}_next.lock")

  # Bundler::Dsl.evaluate already called with an incorrect lockfile ... fix it
  class Bundler::Dsl
    # A bit messy, this can be called multiple times by bundler, avoid blowing the stack
    unless method_defined? :to_definition_unpatched
      alias to_definition_unpatched :to_definition
    end
    def to_definition(_bad_lockfile, unlock)
      to_definition_unpatched(Bundler::SharedHelpers.default_lockfile, unlock)
    end
  end
end

gem "dotenv-rails", :group => [:development, :test, :profiler]

# Framework ------
# RAILS_NEXT is always a future version, tests may not pass yet.
if rails_next?
  # versions are identical until we start the upgrade work
  gem "rails", "4.2.6"
  gem "sprockets-rails", "2.2.0" # lock to avoid asset precompile heroku timeout
  gem "sprockets", "2.11.3"
else
  gem "rails", "4.2.6"
  gem "sprockets-rails", "2.2.0" # lock to avoid asset precompile heroku timeout
  gem "sprockets", "2.11.3"
end

gem "sass-rails", "5.0.0" # Rails 4.2 needs newer sass-rails
gem "responders" # respond_with

# Legacy Rails Extracted Gems
gem "activerecord-session_store", ">= 1.0.0.pre"
gem "protected_attributes" # attr_accessible
gem "rails_autolink"

# Future Rails functionality Gems
gem 'active_record_union'

# Performance
gem "fast_blank", :platform => :mri # a high performance replacement to String#blank?
# gem "oj"         # Optimized JSON
# gem "rails-patch-json-encode" # for Rails 4.0 (not 4.1)

# API v3 ------
gem "graphql"
gem 'graphiql-rails'

# Datastore ------
gem "pg", "0.18.1", :platform => [:mri, :rbx]
gem "activerecord-jdbcpostgresql-adapter", :platform => :jruby

gem "hash_accessor", "1.0.5"
gem "acts_as_list"

gem "paranoia", "~> 2.2"

# Data analysis -----
gem 'descriptive_statistics', '~> 2.4.0', :require => 'descriptive_statistics/safe'
gem 'abanalyzer'
gem 'distribution'
gem "scientist"

# For parsing lengths of time -----
gem 'chronic_duration'

# Cache ------
gem "memcachier", "0.0.2", :group => [:production, :staging, :ondemand]
gem "dalli" # keep this below memcachier
gem "connection_pool"

# Files ------
gem "fog"
gem "unf"
gem "paperclip", "4.2.1"
gem "s3_direct_upload", "0.1.7"
# gem "s3_direct_upload", "0.1.6", :path => "../vendor/s3_direct_upload"
gem "non-stupid-digest-assets"

# Payments ------
gem "recurly", "2.10.1"
gem "braintree"
gem "activemerchant", "1.63.0", :git => "https://github.com/GetJobber/active_merchant.git"
gem "stripe"
gem "plaid"
# Conversions
gem "money"
gem "money-fixer-io"

# Mail/Sms ------
gem "sendgrid_smtpapi"
gem "sendgrid-parse"

gem "mail_view", "~> 2.0.1", :group => [:development, :staging, :test, :profiler, :ondemand]

gem "twilio-ruby"

# View ------
gem "coffee-rails"
gem "uglifier"
gem "eco", "~> 1.0.0"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "jquery-ui-themes"
gem "jscolor-rails"
gem "selectize-rails"
gem "react-rails"
gem 'clipboard-rails', '~> 1.5', '>= 1.5.16'

gem "sass"
gem "gon"

gem "will_paginate", "~> 3.0.7"
gem "coderay", :require => false # used for styleguide and mobile component demos

# Forms ------
gem 'wicked'

# Server ------
gem "puma"
gem "hirefire-resource"
gem "puma_worker_killer"

gem "librato-rails"
gem "rack-cors"
gem 'rack-attack'

# Command line ------
gem "rake"
gem "chartkick"
gem "groupdate"
gem "pry-rails"

# Authentication ------
gem "authlogic", "~> 3.4.2"
gem "scrypt"
# gem "authlogic-oid", :require => "authlogic_openid"
gem "omniauth"
gem "omniauth-openid"
gem "omniauth-google-oauth2"
gem 'omniauth-square', :git => "https://github.com/GetJobber/omniauth-square.git"
# gem "omniauth-square", :path => "../omniauth-square"
gem "oauth2"
# Until this is resolved: https://github.com/google/google-id-token/issues/15
gem "google-id-token", :git => "https://github.com/google/google-id-token.git"

# Localization -------
gem "tzinfo"
gem "carmen" # For regional information (e.g. US states)

# Maps ------
gem "geocoder", "1.2.7"
gem "googlestaticmap"
# gem "googlestaticmap", :path => "../vendor/googlestaticmap"

# PDF Generation ------
gem "prawn", "~> 1.2.1"
gem "prawn-fast-png"
gem "prawn-table", "~> 0.1.2"
gem "prawn-templates", :require => false # for batch invoice delivery (stops working in Prawn 1.3 / pdf-core 0.3+)
gem "prawn-labels", "~> 1.2.1"
gem "prawnto_2", :require => "prawnto"
# gem "prawnto_2", :path => "../prawnto", :require => "prawnto"

# Encoding/Decoding ------
gem "nokogiri"
gem "jwt" # JSON Web Token
gem "hashie", "3.4.0"
gem "htmlentities"

# Background Jobs ------
gem "daemons" # for delayed_job
gem "delayed_job_active_record", "~> 4.0" # comes after protected_attributes gem

# delayed job web is locked to 1.2.5 due to issues in later versions:
# https://github.com/ejschmitt/delayed_job_web/issues
gem "delayed_job_web", "1.2.5", :group => [:production, :staging, :development, :profiler, :ondemand]

# Sidekiq gems
source "https://4ff1824d:f2b86109@gems.contribsys.com/" do
  gem 'sidekiq-pro'
end
gem "sidekiq-status"
gem "sidekiq-throttler"
gem "sidekiq-retry_exceptions"
gem "sinatra", :require => nil
gem "redis-store", ">= 1.2.0.pre"

# Backend
gem "slack-notify"

# Calendaring ------
gem "vpim-rails", :git => "https://github.com/fraser/vpim-rails"
gem "icalendar"

gem "ice_cube", "0.12.1"
gem "recurring_select", "2.0.0"
# gem "recurring_select", :path => "../recurring_select"

# Misc/Support ------
gem "addressable", :require => "addressable/uri"
gem "bigdecimal", ">= 1.2.5", :platform => :mri # For Ruby 2.1
gem "semantic", ">= 1.3.0"
gem "jc-validates_timeliness"
gem "faker"
gem "intercom"

# SalesForce integration ------
gem 'restforce'

# RabbitMQ ------
gem 'bunny'

# Accounting integrations -------------
gem "oauth"
gem "bcrypt"
gem "httparty", ">= 0.8.1"
gem "aes"
gem "xeroizer"

# Other helpful handlers
gem "phony"

# Scheduled Tasks ---------------
gem 'clockwork'

# EventMachine ---------------
gem 'eventmachine'

# Faye --------
gem 'faye'

# TODO: if we weren't specifying tags we could use local overrides
# http://ryanbigg.com/2013/08/bundler-local-paths/

gem "mobile-detection", :git => "https://github.com/GetJobber/mobile-detection.git", :tag => "1.0.8"
# gem "mobile-detection", :path => "../mobile-detection"
gem "required_to_create", :git => "https://github.com/GetJobber/required_to_create.git", :tag => "0.2.3"
# gem "required_to_create", :path => "../required_to_create"
gem "jobber_loc", :git => "https://github.com/GetJobber/jobber_loc.git", :tag => "0.0.50"
gem "jobber_utilities", :git => "https://github.com/GetJobber/jobber_utilities.git", :tag => "0.0.21"
# gem "jobber_utilities", :path => "../jobber_utilities"
gem "router", :git => "https://github.com/GetJobber/Router.git", :tag => "0.0.17"
# gem "router", :path => "../router"

# Internal reporting
gem "jira-ruby", '>= 0.1.14', :require => 'jira'

# Google API client
gem 'google-api-client', '~> 0.9'

# Acts as State Machine
gem "aasm", '>= 4.12.1'

group :production, :staging, :profiler, :ondemand do
  gem "rails_12factor" # for Heroku
  gem "lograge"
end

gem "rollbar"
gem "oj"
gem "httplog"
gem "newrelic_rpm", :group => [:production, :staging, :profiler, :ondemand] # :development

# heroku config:set BUNDLE_WITHOUT="development test profiler"
group :profiler do
  # gem "rack-mini-profiler"
  # gem "memory_profiler", :platform => [:mri, :rbx]
  # gem "flamegraph", :platform => [:mri, :rbx]

  # gem 'rails-perftest'
end

group :profiler, :development do
  gem 'ruby-prof'
  gem 'active_record_query_trace'
end

gem "database_cleaner", :group => [:test, :development, :ondemand]

group :test, :development do
  gem "awesome_print"
  gem "parallel_rspec"
  gem "parallel_tests"
  gem "simplecov", :require => false
  gem "spring-commands-rspec" # Support for spring and rspec setters
  gem "spring-prspec" # Support for Spring under parallel_tests

  gem "jasmine-rails" # RAILS_ENV=test bundle exec rake spec:javascript
  gem "jasmine-jquery-rails"

  gem "pry-rescue"
  gem "pry-stack_explorer", :platform => [:mri, :rbx]
  gem "pry-byebug", '3.3.0', :platform => [:mri] # adds step, next, finish, continue to pry
  gem "poltergeist", "~> 1.15"
end

group :development do
  gem "foreman", :require => false    # for testing Procfile: RACK_ENV=development PORT=3000 foreman start
  gem "quiet_assets"
  gem "meta_request"
  gem "netrc"

  gem "better_errors"

  gem "letter_opener"
  gem "letter_opener_web"
  gem "progress_bar"
  # gem "traceroute" # find unused routes

  gem 'spring', :require => false

  gem "rubocop", "~> 0.47.0", :require => false

  gem 'github_api'
  gem 'terminal-table'
end

group :test do
  gem "rspec", "3.5.0"
  gem "rspec-core"
  gem "rspec-rails", '~> 3.5'
  gem "rspec-set"
  gem "rspec_junit_formatter"
  gem "rspec-prof"

  gem "capybara"
  gem "shoulda-matchers", "2.8.0", :require => false

  gem "factory_girl_rails"

  gem "timecop"
  gem "zonebie" # override with ZONEBIE_TZ="Eastern Time (US & Canada)"

  gem "webmock"
  gem "vcr", "~> 2.9.0"

  gem "test_after_commit"

  gem "stripe-ruby-mock", "~> 2.4.0", :require => "stripe_mock"

  gem "i18n-tasks"

  # RAILS_ENV=test bundle exec mutant -r ./config/environment --use rspec User
  # gem 'mutant'
  # gem 'mutant-rspec'

  # gem "perftools.rb"
  # gem "stackprof"
end

