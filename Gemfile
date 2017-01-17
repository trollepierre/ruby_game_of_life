source 'https://rubygems.org'

ruby '2.3.0'

gem 'sinatra'

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'


  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent'
    gem 'growl' # also install growlnotify
  end

end
group :test do
  gem 'rspec'
  gem 'nyan-cat-formatter'
  gem 'test-unit'
  gem 'rack-test'
  gem 'rspec-mocks'
end
