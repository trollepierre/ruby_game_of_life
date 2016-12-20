require 'rspec'

require_relative '../lib/grid'
require_relative '../lib/table_view'

describe Grid do
  let(:grid) { Grid.new(10, 10) }
  let(:new_grid) { Grid.new(10, 10) }
  let(:alive) { TableView::Plays::ALIVE }
  let(:dead) { TableView::Plays::DEAD }

  describe '#isAlive' do
    context 'Any live cell with fewer than two live neighbours dies' do
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 0)).to be TableView::Plays::DEAD }
    end
    context 'Any live cell with two or three live neighbours lives on to the next generation' do
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 2)).to be TableView::Plays::ALIVE }
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 3)).to be TableView::Plays::ALIVE }
    end
    context 'Any dead cell without 3 neighbours stay dead' do
      it { expect(grid.is_alive(TableView::Plays::DEAD, 2)).to be TableView::Plays::DEAD }
    end
    context 'Any dead cell with exactly three live neighbours becomes a live cell' do
      it { expect(grid.is_alive(TableView::Plays::DEAD, 3)).to be TableView::Plays::ALIVE }
    end
    context 'Any live cell with more than three live neighbours die' do
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 4)).to be TableView::Plays::DEAD }
    end
  end

  describe '#number_of_alive_neighbours' do
    context 'no one' do
      it { expect(grid.number_of_alive_neighbours(5, 5)).to be 0 }
    end
    context 'one neighbour cell' do
      before do
        grid.add_cell(5, 4, alive)
      end
      it { expect(grid.number_of_alive_neighbours(5, 5)).to be 1 }
    end
    context 'a lot of cells' do
      before do
        grid.add_cell(5, 4, alive)
        grid.add_cell(5, 5, alive)
        grid.add_cell(6, 4, dead)
        grid.add_cell(5, 6, alive)
        grid.add_cell(4, 4, alive)
      end
      it { expect(grid.number_of_alive_neighbours(5, 5)).to be 3 }
    end
  end

  describe '#nextState' do
    context 'no cell stay dead' do
      it { expect(grid.next_state(5, 5)).to be dead }
    end
    context 'one cell survive on three adjacent ones' do
      before do
        grid.add_cell(4, 4, alive)
        grid.add_cell(5, 5, alive)
        grid.add_cell(6, 6, alive)
      end
      it { expect(grid.next_state(5, 5)).to be alive }
    end
    context 'a complex cell changes' do
      before do
        grid.add_cell(4, 5, alive)
        grid.add_cell(5, 4, alive)
        grid.add_cell(5, 5, alive)
        grid.add_cell(5, 6, alive)
        grid.add_cell(6, 5, alive)
      end
      it { expect(grid.next_state(4, 4)).to be alive }
      it { expect(grid.next_state(4, 5)).to be alive }
      it { expect(grid.next_state(4, 6)).to be alive }
      it { expect(grid.next_state(5, 4)).to be alive }
      it { expect(grid.next_state(5, 5)).to be dead }
      it { expect(grid.next_state(5, 6)).to be alive }
      it { expect(grid.next_state(6, 4)).to be alive }
      it { expect(grid.next_state(6, 5)).to be alive }
      it { expect(grid.next_state(6, 6)).to be alive }
    end
  end

  describe '#state' do
    it { expect(grid.state(6, 6)).to be dead }
  end

  describe '#next' do
    context 'a complex cell changes' do
      before do
        grid.add_cell(4, 5, alive)
        grid.add_cell(5, 4, alive)
        grid.add_cell(5, 5, alive)
        grid.add_cell(5, 6, alive)
        grid.add_cell(6, 5, alive)
      end
      it do
        new_grid = grid.next()
        expect(new_grid.state(4, 4)).to be alive
        expect(new_grid.state(4, 5)).to be alive
        expect(new_grid.state(4, 6)).to be alive
        expect(new_grid.state(5, 4)).to be alive
        expect(new_grid.state(5, 5)).to be dead
        expect(new_grid.state(5, 6)).to be alive
        expect(new_grid.state(6, 4)).to be alive
        expect(new_grid.state(6, 5)).to be alive
        expect(new_grid.state(6, 6)).to be alive
      end
    end
  end
end

