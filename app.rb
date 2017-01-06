# app.rb
require 'sinatra'
require 'json'

class HelloWorldApp < Sinatra::Base
  get '/' do
    "Hello, world!"
  end

  post '/' do
    "Hello, world!"
  end

  get '/hello/?:name?' do
    "Hello, #{params[:name] ? params[:name] : 'world'}!"
  end

  get '/height' do
    1000
  end

  get '/width' do
    500
  end

  get('/login') do
    "Please login"
  end

  post('/login') do
    if params['name'] == 'admin' && params['password'] == 'pwd'
      session['user_name'] = params['name']
      "Succès"
    else
      redirect '/login'
    end
  end

  post '/evolve' do
    height = params['height']
    width = params['width']
    my_cells = params['cells']['myCells']
    x = my_cells[0]['state']
  "1ère cell reçue is :"+x+" height : " + height + " width : " + width
  end
end