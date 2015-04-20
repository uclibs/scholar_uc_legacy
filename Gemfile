source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.11'

# Use mysql2 as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

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

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use passenger as the app server
# gem 'passenger'

# Use Capistrano for deployment

# Use debugger

gem "kaminari", "0.15.1"

gem "curate", git: "https://github.com/uclibs/curate_fork.git", ref: "69186c23e1f5c4fa00adf5fcfe8e6e577c98981e"
gem "clamav"

gem "bootstrap-sass"
gem "font-awesome-sass"
gem "font-awesome-rails", "4.2.0.0"

gem "devise"
gem "devise-guests", "~> 0.3"


group :development, :test do
  gem 'sqlite3'
  gem "jettywrapper"
  # gem 'debugger'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  # gem 'capistrano'
end

group :test do
  gem 'factory_girl_rails', '~>4.2.0'
  gem 'poltergeist'
  gem 'rspec-html-matchers', '~>0.4'
  gem 'rspec-rails', '~>2.14.0'
  gem 'capybara', "~> 2.1"
#  gem 'vcr'
#  gem 'webmock'
#  gem 'database_cleaner', '< 1.1.0'
end
