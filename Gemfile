source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use LESS for stylesheets
gem 'less-rails', '~> 2.4.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Requied 'cos the rvm said
gem 'execjs', '~> 2.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.0.4'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '1.3.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Finite state machine
gem 'state_machine'

# Rest client for mailgun
gem 'rest-client'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
# gem "rspec-rails"
	gem 'debugger'
  # Download popular i18n local files
  gem 'i18n_generators'
  # Replace the default error page for REPL, stack trace and variable inspection
  gem 'better_errors'
  # Pry extension for better trace and REPL
  gem 'binding_of_caller'
  # RailsPanel Chrome extension
  gem 'meta_request'
  gem 'psych'
  gem 'factory_girl_rails', "~> 4.0"
  # Pry support
  gem 'pry-rails'
  # Pry extension for navigation
  gem 'pry-nav'
  # ER Diagram generator
  gem 'railroady'
  # Rubocop for testing metrics
  gem 'rubocop'
  # Roodi for testing metrics
  gem 'roodi'
  # Best Practices for code metrics
  gem "rails_best_practices"
  # Vulnerability scanner
  gem "brakeman", :require => false
end

group :test do
	gem 'cucumber-rails', :require => false
	gem 'database_cleaner'
	gem 'mongoid-rspec'
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end

# Monitoring with New Relic service
gem 'newrelic_rpm'

# Devise for auth
gem 'devise', '3.1.0'

# MongoDB miatt a mongoid wrapper
gem 'mongoid', git: 'https://github.com/mongoid/mongoid.git'

# Mongoid said it's need the bson_ext so here it is
gem 'bson_ext', '1.9.2'

# Bootstrap
group :assets do
	gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass', branch: '3'
	gem 'twitter-bootstrap-rails', '2.2.8'
end

# Replace confirm dialogs
gem 'data-confirm-modal', github: 'ifad/data-confirm-modal'

# The recommended doorkeeper for OAuth
gem 'doorkeeper', '~> 0.7.1'

# Use dragonfly for file uploads
gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly', '~>0.9.15'

# For Forms
gem 'simple_form', '1.4.1'

# Perform some Android analysis
gem 'ruby_apk'

# Perform some iOS analysis
gem "ipa"

# Perform Zip commands
gem 'rubyzip', "~> 0.9.9"

# To perform copy-to-clipboard
gem 'zeroclipboard-rails', '0.0.7'

# JQuery compatibility issues workround
gem 'jquery-turbolinks'

# Nice transitions
gem 'nprogress-rails', '0.1.2.3'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
