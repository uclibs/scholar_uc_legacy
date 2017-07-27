# frozen_string_literal: true
source 'https://rubygems.org'

gem 'hyrax', '1.0.1'
gem 'active-fedora', '11.2.0'
gem 'hydra-head', '10.4.0'

# repository manager
gem 'hydra-role-management'
gem 'orcid', github: 'uclibs/orcid', branch: 'rails-5'
gem 'devise-multi_auth', github: 'uclibs/devise-multi_auth', branch: 'rails-5'
gem 'riiif', '~> 0.2.0'
gem 'iiif_manifest', '~> 0.1.2'
gem 'hydra-remote_identifier', github: 'uclibs/hydra-remote_identifier', branch: 'setting-status'
gem 'browse-everything', git: 'https://github.com/uclibs/browse-everything.git', ref: 'be25819f14d485768698d27a3a35deaa7f60d5c7'
gem 'kaltura', '0.1.1'

# Shibboleth
gem 'omniauth-openid'
gem 'omniauth-shibboleth'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
# gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'sidekiq'

gem 'change_manager', git: "https://github.com/lawhorkl/change_manager.git", ref: '8d151d1123aa35658f061a63bc72435afdf0ec8a'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# gem 'clamav'

gem 'mysql2'

group :development, :test do
  gem 'brakeman', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rb-readline'
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  gem 'solr_wrapper', '>= 0.13'
end

gem 'rsolr', '~> 1.0'
gem 'devise'
gem 'devise-guests', '~> 0.5'
group :development, :test do
  gem 'vcr'
  gem 'webmock'
  gem 'fcrepo_wrapper'
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-its', '~> 1.2'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'show_me_the_cookies'
end

group :development, :test do
  gem 'coveralls', require: false
  gem 'rubocop', '~> 0.48.1'
  # version has to be exactly 1.7, no variation.
  gem 'rubocop-rspec', '1.10.0'
  gem 'rails-controller-testing'
end
