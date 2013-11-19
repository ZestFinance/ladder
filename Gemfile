source 'https://rubygems.org'
gem 'rails', '~> 4.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'mysql2'
gem 'pg'
gem 'trueskill', :git => 'git://github.com/saulabs/trueskill.git', :require => "saulabs/trueskill"
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'therubyracer'
gem 'less-rails'
gem 'unicorn'
gem 'thin'
gem 'syslogger'
gem 'compass-rails', github: 'Compass/compass-rails'
gem 'chosen-rails', '~> 1.0.1'

# Gems used only for assets and not required
# in production environments by default.
# group :assets do
gem 'sass-rails',   '~> 4.0.1'
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'
#  gem 'twitter-bootstrap-rails', '~> 2.2.8'
# end

gem 'jquery-rails'

group :development do
  gem "pry", "~> 0.9.8"
  gem "pry-doc"
  gem "pry-stack_explorer"
  gem "timecop"
  gem 'debugger'
end

group :development, :test do
  gem "rspec-rails", ">= 2.8.1"
  gem 'quiet_assets'
end

group :test do
  gem "cucumber-rails", "1.3.0", require: false
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
end
