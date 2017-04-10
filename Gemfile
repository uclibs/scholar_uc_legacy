source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.13'

gem 'byebug'

# Use mysql2 as the database for Active Record
gem 'mysql2', '0.3.20'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'orcid', :github => 'uclibs/orcid'

gem 'devise-multi_auth', github: 'uclibs/devise-multi_auth'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.1.4'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.5.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '1.5.3'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use passenger as the app server
# gem 'passenger'

# Use Capistrano for deployment

# Use debugger

gem "kaminari", "0.15.1"

gem "curate", git: "https://github.com/uclibs/curate.git", ref: "09fd89847fc397514814b546faeb4f38ea8b166f"
gem 'browse-everything', git: 'https://github.com/uclibs/browse-everything.git', ref: "8c0db2a476cce08210da2a67a2c3bddf284271c7"
gem 'kaltura', '0.1.1'


#gem "clamav"
gem "hydra-remote_identifier", github: "uclibs/hydra-remote_identifier", ref: "bbc060d2d054fd31225321d385cfcfd8d6e5b253"
gem "sitemap_generator", '5.2.0'

group :production do
  gem 'exception_notification', '4.2.1'
end

#change manager gem for automatic notification management, requires resque and resque-scheduler
gem 'resque', '1.26.0'
gem 'resque-scheduler', '4.3.0'
gem 'change_manager', '1.0.0'

gem "bootstrap-sass", '2.3.2.2'
gem "font-awesome-sass", '4.7.0'
gem "font-awesome-rails", "4.2.0.0"

gem "devise", '3.2.4'
gem "devise-guests", "0.5.0"

gem 'openseadragon', '0.1.0'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem "jettywrapper", '1.8.3'
  # gem 'debugger'
end

group :development do
  gem "better_errors", "2.1.1"
  gem "binding_of_caller", "0.7.2"
  gem "quiet_assets", "1.1.0"
  # gem 'capistrano'
end

group :test do
  gem 'factory_girl_rails', '4.2.0'
  gem 'poltergeist', '1.13.0'
  gem 'rspec-html-matchers', '0.5.0'
  gem 'rspec-rails', '~>2.14.2'
  gem 'capybara', "2.12.0"
  gem 'show_me_the_cookies', '3.1.0'
#  gem 'vcr'
#  gem 'webmock'
#  gem 'database_cleaner', '< 1.1.0'
end

gem 'omniauth-openid', '1.0.1'
gem 'omniauth-shibboleth', '1.2.1'
gem 'feedjira', '2.1.0'

gem 'rake', '11.2.2'
