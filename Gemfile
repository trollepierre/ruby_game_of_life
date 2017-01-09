source 'https://rubygems.org'

ruby '2.3.0'

gem "nyan-cat-formatter"

group :development do  
  gem 'guard' 
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'sinatra'
  gem 'rack-test'
  gem 'test-unit'

  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent'
    gem 'growl' # also install growlnotify
  end

end  
group :test do
  gem 'rspec'
  gem 'rspec-mocks'
end
