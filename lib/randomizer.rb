require_relative '../lib/grid'

class Randomizer
  def get_grid width, height
    grid = Grid.new(width, height)
    for x in 1..width
      for y in 1..height
        state = halfChance ? TableView::Plays::ALIVE : TableView::Plays::DEAD
        grid.add_cell(x, y, state)
      end
    end
    grid
  end

  def halfChance
    rand(2) == 1
  end
end