source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.1.8'
gem 'pg'
gem 'firebase'
gem 'autoprefixer-rails'
gem 'bootstrap-sass', '~> 3.3.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bower-rails'
gem 'haml_coffee_assets', :github => 'netzpirat/haml_coffee_assets'  # XXX https://github.com/netzpirat/haml_coffee_assets/issues/130
gem 'i18n-js', '~>3.0.0.rc8'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'haml-rails'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'sendgrid'
gem 'rack-canonical-host'
group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'exception_notification'
end
group :development do
  gem 'dotenv-rails'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'foreman'
  gem 'guard-bundler'
  gem 'guard-pow'
  gem 'guard-rspec'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring'
  gem 'spring-commands-rspec'
end
group :development, :test do
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
