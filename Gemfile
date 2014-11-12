source 'https://rubygems.org'

ruby '2.1.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
gem 'pg'
gem 'devise'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.2.0'
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'figaro'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# add jQuery UI components
gem 'jquery-ui-sass-rails'
# bundle exec rake doc:rails generates the API under doc/api.

group :development, :test do
    gem 'rspec-rails', '~> 3.0.0'
end

group :test do
    gem 'cucumber-rails', :require => false
    # database_cleaner is not required, but highly recommended
    gem 'database_cleaner'
    gem 'selenium-webdriver'
    gem 'capybara'
    gem 'factory_girl_rails'
    # for checking test coverage
    gem 'simplecov', :require => false
    gem "faker", "~> 1.4.3"
    gem "launchy", "~> 2.4.2"
    gem 'shoulda-matchers', require: false
end

group :development do
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'letter_opener'
end

group :doc do
    gem 'sdoc', '0.4.0', require: false
end

group :production do
    gem 'rails_12factor'
end
