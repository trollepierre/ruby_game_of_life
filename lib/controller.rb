require_relative '../lib/file_manager'

class Controller

  def initialize file_manager
    @file_manager = file_manager
  end

  def sayHi
    "Hello, world!"
  end

  def getGrid id
    grid = @file_manager.getNotNullFormattedGridFromReadFile(id)
    next_grid = grid.next
    grid_to_json = @file_manager.new_format_grid(next_grid)
    @file_manager.save(grid_to_json, id)
    grid_to_json
  end

end