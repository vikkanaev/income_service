source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'awesome_print', '~> 1.9.2'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3'

gem 'dry-initializer', '~> 3.0.3'
gem 'money-rails', '~>1.12'

gem 'fast_jsonapi', '~> 1.5'
gem 'kaminari', '~> 1.2.1'
gem 'rails-i18n', '~> 6.0.0'

gem 'bcrypt', '~> 3.1.7'
gem 'jwt', '~> 2.2.1'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'pry'
  gem 'rspec-rails', '~> 5.0.1'
  gem 'rubocop', '~> 1.11', require: false
  gem 'rubocop-performance', '~>1.10.1', require: false
  gem 'rubocop-rspec', '~>2.2.0', require: false
  gem 'timecop', '~> 0.9.4'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner-active_record', '~> 1.8.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
