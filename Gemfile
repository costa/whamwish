source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '~>4.2.0'
gem 'pg'
gem 'firebase'
gem 'responders'
gem 'autoprefixer-rails'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'sass-rails', '~> 5.0.1'
gem 'uglifier'
gem 'coffee-rails', '~> 4.1.0'
gem 'bower-rails'
gem 'haml_coffee_assets', :github => 'netzpirat/haml_coffee_assets'  # XXX https://github.com/netzpirat/haml_coffee_assets/issues/130
gem 'i18n-js', '~>3.0.0.rc8'
gem 'haml-rails'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'sendgrid'
gem 'rack-canonical-host'

gem 'sdoc', :group => :doc

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'exception_notification'
end
group :development do
  gem 'dotenv-rails'
  gem 'letter_opener'
  gem 'foreman'
  gem 'guard-bundler'
  gem 'guard-pow'
  gem 'guard-rspec'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'html2haml', :require => false
  gem 'hub', :require => nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'spring'
  gem 'spring-commands-rspec'
end
group :development, :test do
  gem 'web-console'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-byebug'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end
