source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem 'bundler'
gem 'will_paginate'
gem "nifty-generators", :group => :development
gem 'mocha'
gem 'formtastic'
gem 'validates_timeliness'
gem 'bcrypt-ruby', :require=>"bcrypt"
gem 'cancan'
gem 'jquery-rails'

group :development, :test do
  gem 'pry'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem "factory_girl_rails"
  gem "annotate"
  gem "guard-test"
  gem "guard-cucumber"
  gem "guard-rspec"
  gem "cucumber-rails"
  gem "rspec-rails"
  gem "database_cleaner"
  gem "email_spec"
  gem "capybara-webkit"
  gem "launchy"
end

group :production do
	#gem 'mysql2'
  gem 'pg'
end
gem "mocha", :group => :test
