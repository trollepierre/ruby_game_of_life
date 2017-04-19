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

  def count_cells id, state
    grid = @file_manager.getNotNullFormattedGridFromReadFile(id)

    # not tested
    if grid.count(state) == 0
      grid = @file_manager.getNotNullFormattedGridFromReadFile(id)
    end

    grid.count(state).to_s
  end

end