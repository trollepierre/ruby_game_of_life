require 'json'
require_relative 'grid'

class FileManager
  def save grid, id
    begin
      file = File.open('data/filename_' + id.to_s, 'w')
      file.write(grid)
      file.close
    rescue => err
      "Exception: #{err.message}"
    end
  end

  def readFile id
    begin
      file = File.open('data/filename_' + id.to_s, 'r')
      content = file.read
      file.close
      content
    rescue => err
      "Exception: #{err.message}"
    end
  end

# do while ruby
# gestion d'erreurs
  def getNotNullFormattedGridFromReadFile id
    contenu = readFile(id)
    while contenu == nil do
      contenu = readFile(id)
    end
    grid = reformat_grid(contenu)
    while grid == {} do
      contenu = readFile(id)
      grid = reformat_grid(contenu)
    end
    grid
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
    count = 0
    while contenu == nil && count < 10 do
      contenu = JSON.load(formatted_grid)
      count += 1
    end

    #fix bug
    if contenu == nil
      puts "Exception: empty content: #{formatted_grid}"
      contenu = JSON.load('[{"x":1,"y":1,"state":"dead"}]')
    end

    length = contenu[contenu.length - 1]['x']
    height = contenu[contenu.length - 1]['y']
    grid = Grid.new(length, height)

    for i in 0 .. contenu.length - 1
      if contenu[i]['state'] == 'alive'
        grid.add_cell(contenu[i]['x'].to_i, contenu[i]['y'].to_i, 'alive')
      end
    end
    grid
  end

end
