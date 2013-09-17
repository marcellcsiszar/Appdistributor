source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

gem 'less-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Requied 'cos the rvm said
gem 'execjs'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
	gem "rspec-rails"
end

group :test do
	gem 'cucumber-rails', :require => false
	gem 'database_cleaner'
	gem 'mongoid-rspec'
end

# Devise for auth
gem 'devise'

# MongoDB miatt a mongoid wrapper
gem 'mongoid', git: 'https://github.com/mongoid/mongoid.git'

# Mongoid said it's need the bson_ext so here it is
gem 'bson_ext'

# Bootstrap for SWAG
group :assets do
	gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass', branch: '3'
	gem 'twitter-bootstrap-rails'
end

# The recommended doorkeeper for OAuth
gem 'doorkeeper', '~> 0.7.1'

# Use dragonfly for file uploads
gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly', '~>0.9.15'

# For Forms
gem 'simple_form'
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
