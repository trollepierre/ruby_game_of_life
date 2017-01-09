require 'rspec'
require_relative 'lib/grid'
require_relative 'lib/table_view'

length = 10
height = 10
number_of_tours = 10

def init(grid)
  grid.add_cell(4, 5, TableView::Plays::ALIVE)
  grid.add_cell(5, 4, TableView::Plays::ALIVE)
  grid.add_cell(5, 5, TableView::Plays::ALIVE)
  grid.add_cell(5, 6, TableView::Plays::ALIVE)
  grid.add_cell(6, 5, TableView::Plays::ALIVE)
end

grid = Grid.new(length, height)
tableview = TableView.new
init(grid)


(0.. number_of_tours).each { |tour|
  puts tableview.display(grid, tour)
  grid = grid.next
}
