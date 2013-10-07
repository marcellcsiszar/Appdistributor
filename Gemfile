source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

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

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
	gem "rspec-rails"
	gem 'debugger'
  gem 'i18n_generators'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'psych'
  gem 'factory_girl_rails', "~> 4.0"
  gem 'pry-rails'
  gem 'pry-nav'
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

# Devise for auth
gem 'devise', '3.1.0'

# MongoDB miatt a mongoid wrapper
gem 'mongoid', git: 'https://github.com/mongoid/mongoid.git'

# Mongoid said it's need the bson_ext so here it is
gem 'bson_ext', '1.9.2'

# Bootstrap for SWAG
group :assets do
	gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass', branch: '3'
	gem 'twitter-bootstrap-rails', '2.2.8'
end

# The recommended doorkeeper for OAuth
gem 'doorkeeper', '~> 0.7.1'

# Use dragonfly for file uploads
gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly', '~>0.9.15'

# For Forms
gem 'simple_form', '1.4.1'

# Perform some Android analysis
gem 'ruby_apk', '0.6.0'

# Perform some iOS analysis
gem "ipa_reader"

# Perform Zip commands
gem 'rubyzip',  "~> 0.9.9"

# To perform copy-to-clipboard
gem 'zeroclipboard-rails',  '0.0.7'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
