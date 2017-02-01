# app.rb
require 'sinatra'
require 'json'
require_relative 'lib/file_manager'
require_relative 'lib/table_view'
# require 'sinatra/cross_origin'


class RouteApp < Sinatra::Base
  file_manager = FileManager.new

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
    if params[:id]
      id = params[:id]

      # getFormattedGrid
      contenu = file_manager.getGrid(id)
      grille = JSON.load(contenu)
      grid = file_manager.reformat_grid(grille)

      #evolve
      next_grid = grid.next

      #save grid
      grid_to_json = file_manager.format_grid(next_grid).to_json
      file_manager.save(grid_to_json, id)

      #return grid
      headers 'Access-Control-Allow-Origin' => '*'
      return grid_to_json
    end
    'FAUSSE REQUETE'
  end

  get '/create' do
    # create random grid
    length = 100
    height = 30
    id = 100

    grid = Grid.new(length, height)

    for x in 1..length
      for y in 1..height
        state = rand(2) == 1 ? TableView::Plays::ALIVE : TableView::Plays::DEAD
        grid.add_cell(x, y, state)
      end
    end

    grid_to_json = file_manager.format_grid(grid).to_json
    file_manager.save(grid_to_json, id)

    headers 'Access-Control-Allow-Origin' => '*'
    grid_to_json
  end


  post('/grids') do
    # cross_origin :allow_origin => 'http://localhost:8080'
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

    # headers 'Access-Control-Allow-Origin' => '*'
    grid_to_json
    # headers 'Access-Control-Allow-Origin' => '*'
  end
end
