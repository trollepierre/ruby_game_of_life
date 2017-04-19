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

  configure do
    set :allow_origin, :any
    enable :cross_origin
  end

  get '/' do
    controller.sayHi()
  end

  get '/grids/:id' do
    id = params[:id]
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    controller.getGrid(id)
  end

  get '/grids/:id/count/:state' do
    id = params[:id]
    state = (params[:state] == 'dead') ? TableView::Plays::DEAD : TableView::Plays::ALIVE
    headers 'Access-Control-Allow-Origin' => '*'
    controller.count_cells(id, state)
  end

  get '/newCreate/:id/height/:height/width/:width' do
    id = params[:id].to_i
    height = params[:height].to_i
    width = params[:width].to_i

    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    controller.create_grid(id, width, height)
  end

  post('/grids') do

    length = params['length'].to_i
    height = params['height'].to_i
    id = 100

    grid = Grid.new(length, height)

    for x in 1..length
      for y in 1..height
        grid.add_cell(x, y, TableView::Plays::DEAD)
      end
    end

    grid.add_cell(4, 5, TableView::Plays::ALIVE)
    grid.add_cell(5, 4, TableView::Plays::ALIVE)
    grid.add_cell(5, 5, TableView::Plays::ALIVE)
    grid.add_cell(5, 6, TableView::Plays::ALIVE)
    grid.add_cell(6, 5, TableView::Plays::ALIVE)

    grid_to_json = file_manager.format_grid(grid).to_json

    file_manager.save(grid_to_json, id)

    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    grid_to_json
  end
end
