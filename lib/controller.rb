require_relative '../lib/file_manager'
require_relative '../lib/randomizer'

class Controller

  def initialize(file_manager, randomizer)
    @file_manager = file_manager
    @randomizer = randomizer
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
    state = (state == 'dead') ? TableView::Plays::DEAD : TableView::Plays::ALIVE
    grid = @file_manager.getNotNullFormattedGridFromReadFile(id)

    # not tested
    if grid.count(state) == 0
      grid = @file_manager.getNotNullFormattedGridFromReadFile(id)
    end

    grid.count(state).to_s
  end

  def create_grid id, width, height
    grid = @randomizer.get_grid(width.to_i, height.to_i)

    # to be removed ?
    FileUtils.mkdir_p('data') unless File.exist?('data')

    grid_to_json = @file_manager.new_format_grid(grid)
    @file_manager.save(grid_to_json, id)
    grid_to_json
  end

end