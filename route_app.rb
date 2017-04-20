# app.rb
require 'sinatra'
require 'json'
require_relative 'lib/file_manager'
require_relative 'lib/randomizer'
require_relative 'lib/table_view'
require_relative 'lib/controller'
require 'sinatra/cross_origin'

class RouteApp < Sinatra::Base
  file_manager = FileManager.new
  randomizer = Randomizer.new
  controller = Controller.new file_manager, randomizer

  get '/' do
    controller.sayHi
  end

  get '/grids/:id' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    controller.getGrid params[:id]
  end

  get '/grids/:id/count/:state' do
    headers 'Access-Control-Allow-Origin' => '*'
    controller.count_cells(params[:id], params[:state])
  end

  get '/newCreate/:id/height/:height/width/:width' do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    controller.create_grid(params[:id], params[:width], params[:height])
  end
end
