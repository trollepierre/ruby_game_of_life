source 'https://rubygems.org'

ruby '2.7.0'

gem 'sinatra'

group :production do
  # if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent'
    gem 'growl' # also install growlnotify
    gem 'sinatra-cross_origin', '~> 0.3.1'
  # end
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
end

group :test do
  gem 'rspec'
  gem 'nyan-cat-formatter'
  gem 'test-unit'
  gem 'rack-test'
  gem 'rspec-mocks'
end
