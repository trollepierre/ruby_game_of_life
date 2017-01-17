# app.rb
require 'sinatra'
require 'json'
require_relative 'lib/file_manager'
require_relative 'lib/table_view'

class RouteApp < Sinatra::Base
  file_manager = FileManager.new

  get '/' do
    "Hello, world!"
  end

  get '/grid/' do
    "Proud of grid"
  end

  get '/grid/100/' do
    "Proud of you"
  end

  get '/grid/:id/' do
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
      return grid_to_json
    end
    'FAUSSE REQUETE'
  end

  post('/create') do
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
    redirect '/grid/'+id.to_s
  end

  post '/evolve' do
    height = params['height']
    length = params['length']
    my_cells = params['cells']['myCells']
    x = my_cells[0]['state']
    "1ère cell reçue is :" + x + " height : " + height + " length : " + length
  end
end

# Demande à ABA s'il a fait ça ?

# Demande à TPA pourquoi mes 2 mocks - xit - ne marchent pas

# à DAB, JJA ? : indente automatique