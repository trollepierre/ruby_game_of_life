require 'json'
require_relative 'grid'

class FileManager
  def save grid, id
    File.open "filename_"+id.to_s, "w" do |file|
      file.write(grid)
    end
  end

  def getGrid id
    begin
      file = File.open("filename_"+id.to_s, "r")
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
    { length: grid.length, height: grid.height, cells: grid.matrix}
  end

  def reformat_grid formatted_grid
    grid = Grid.new(formatted_grid["length"],formatted_grid["height"])
    grid.add_matrix(formatted_grid["cells"])
    grid
  end
end
