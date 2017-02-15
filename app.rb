# app.rb
require 'sinatra'
require 'json'
require_relative 'lib/file_manager'
require_relative 'lib/table_view'
require 'sinatra/cross_origin'

class RouteApp < Sinatra::Base
  # register Sinatra::CrossOrigin
  file_manager = FileManager.new


  configure do
# Comma separate list of remote hosts that are allowed.
# :any will allow any host
    set :allow_origin, :any
    enable :cross_origin

# HTTP methods allowed
#      set :allow_methods, [:head, :options, :get, :post]

# Allow cookies to be sent with the requests
#     set :allow_credentials, true
  end

  # before do
  #   content_type :json
  #   headers 'Access-Control-Allow-Origin' => '*'
  #           # ,'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
  # end

=begin
  configure do
    enable :cross_origin
    set :allow_origin, :any
    set :allow_methods, [:get, :post, :options]
    set :allow_credentials, true
    set :max_age, "1728000"
    set :expose_headers, ['Content-Type']
  end
=end

  # options "*" do
  #   response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
  #   response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  #   200
  # end

  get '/' do
    "Hello, world!"
  end

  get '/grids/:id' do
    id = params[:id]

    # getFormattedGrid
    contenu = file_manager.readFile(id)

    grid = file_manager.reformat_grid(contenu)

    #evolve
    next_grid = grid.next

    #save grid
    grid_to_json = file_manager.new_format_grid(next_grid)
    file_manager.save(grid_to_json, id)

    #return grid
    headers 'Access-Control-Allow-Origin' => '*'
    return grid_to_json
  end

  get '/newCreate/:id/height/:height/width/:width' do
#  envoi d'un [ { x: 1, y:1, state : "dead" },
    id = params[:id].to_i
    height = params[:height].to_i
    length = params[:width].to_i
    id = 100

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
    binding.pry
    grid_to_json
  end
end
