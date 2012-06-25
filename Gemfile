source 'http://rubygems.org'

gem 'rails', '2.3.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'will_paginate', '2.3.16'
gem 'aws-s3', :require => 'aws/s3'

gem 'negative-captcha', :git => 'git://github.com/stefants/negative-captcha.git'
gem 'jfabre-actionwebservice', :require => 'actionwebservice'
gem 'trackman'
group :development do
  gem 'sqlite3-ruby', '1.3.1', :require => 'sqlite3'
  gem 'mongrel', '1.2.0.pre2'
  gem 'heroku'
  gem 'taps'
end

group :test do
  gem 'rspec'
  gem "capybara", "1.1.1"
  gem "cucumber", "1.1.0"
  gem "pickle"
  gem "cucumber-rails", "0.3.2"
  gem 'database_cleaner'
  gem 'webrat'
  gem 'rspec-rails'
  gem 'spork'
end
group :production do
  gem 'pg' 
end


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
