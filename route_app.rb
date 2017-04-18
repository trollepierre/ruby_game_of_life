# app.rb
require 'sinatra'
require 'json'
require_relative 'lib/file_manager'
require_relative 'lib/table_view'
require_relative 'lib/controller'
require 'sinatra/cross_origin'

class RouteApp < Sinatra::Base
  file_manager = FileManager.new
  controller = Controller.new

  configure do
    set :allow_origin, :any
    enable :cross_origin
  end

  get '/' do
    controller.sayHi()
  end

  get '/grids/:id' do
    id = params[:id]

    grid = file_manager.getNotNullFormattedGridFromReadFile(id)

    next_grid = grid.next

    grid_to_json = file_manager.new_format_grid(next_grid)
    file_manager.save(grid_to_json, id)

    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    grid_to_json
  end

  get '/grids/:id/count/:state' do
    id = params[:id]
    state = (params[:state] == 'dead') ? TableView::Plays::DEAD : TableView::Plays::ALIVE

    grid = file_manager.getNotNullFormattedGridFromReadFile(id)

    headers 'Access-Control-Allow-Origin' => '*'
    if grid.count(state) == 0
      grid = file_manager.getNotNullFormattedGridFromReadFile(id)
    end
    grid.count(state).to_s
  end

  get '/newCreate/:id/height/:height/width/:width' do
    FileUtils.mkdir_p('data') unless File.exist?('data')
    id = params[:id].to_i
    height = params[:height].to_i
    length = params[:width].to_i

    grid = Grid.new(length, height)

    for x in 1..length
      for y in 1..height
        state = rand(2) == 1 ? TableView::Plays::ALIVE : TableView::Plays::DEAD
        grid.add_cell(x, y, state)
      end
    end
    grid.add_cell(1, 1, TableView::Plays::DEAD)

    grid_to_json = file_manager.new_format_grid(grid)
    file_manager.save(grid_to_json, id)

    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
    grid_to_json
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
