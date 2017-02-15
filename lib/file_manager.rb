require 'json'
require_relative 'grid'
require 'pry'


class FileManager
  def save grid, id
    File.open 'filename_'+id.to_s, 'w' do |file|
      file.write(grid)
    end
  end

  def readFile id
    begin
      file = File.open('filename_' + id.to_s, 'r')
      contenu = file.read
      file.close
      contenu
    rescue => err
      puts "Exception: #{err}"
      err
    end
    contenu
  end

  def format_grid grid
    {length: grid.length, height: grid.height, cells: grid.matrix}
  end

  def new_format_grid grid
    result = []
    for x in 1 .. grid.length
      for y in 1 .. grid.height
        state = grid.state(x, y)
        result << {x: x, y: y, state: state}
      end
    end
    # result
    result.to_json
  end

  def reformat_grid formatted_grid
    contenu = JSON.load(formatted_grid)
    length = contenu[contenu.length - 1]['x']
    height = contenu[contenu.length - 1]['y']
    grid = Grid.new(length, height)

    for i in 0 .. contenu.length - 1
      if contenu[i]['state'] == "alive"
        grid.add_cell(contenu[i]['x'].to_i, contenu[i]['y'].to_i, "alive")
      end
    end
    grid
  end
end
