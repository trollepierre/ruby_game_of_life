class Grid
  attr_reader :matrix, :length, :height, :cell

  def initialize(length, height)
    @matrix = {}
    @length = length
    @height = height
  end

  def is_alive(state, number_of_neighbours)
    return TableView::Plays::DEAD if state == TableView::Plays::DEAD and number_of_neighbours != 3
    return TableView::Plays::ALIVE if number_of_neighbours >= 2 and number_of_neighbours <= 3
    TableView::Plays::DEAD
  end

  def state(x, y)
    return  TableView::Plays::DEAD if @matrix[[x, y]] == nil
    @matrix[[x, y]]
  end

  def add_cell(x, y, state)
    @matrix[[x, y]] = state
  end

  def next_state(x, y)
    is_alive(state(x, y), number_of_alive_neighbours(x, y))
  end

  def next()
    new_grid = Grid.new(@length, @height)
    for x in 1..@length
      for y in 1..@height
        new_grid.add_cell(x, y, next_state(x, y))
      end
    end
    new_grid
  end

  def number_of_alive_neighbours(x, y)
    neighbours = 0
    neighbours= -1 if state(x, y) == TableView::Plays::ALIVE
    for abs in x - 1 .. x + 1
      for ord in y - 1 .. y + 1
        if @matrix[[abs, ord]] == TableView::Plays::ALIVE
          neighbours += 1
        end
      end
    end
    neighbours
  end

end