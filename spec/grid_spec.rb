require 'rspec'

require_relative '../lib/grid'
require_relative '../lib/table_view'

describe Grid do
  let(:one_cells_grid) { Grid.new(1, 1) }
  let(:grid) { Grid.new(10, 10) }
  let(:new_grid) { Grid.new(10, 10) }
  let(:fake_grid) { Grid.new(5, 10) }
  let(:wrong_grid) { Grid.new(10, 5) }
  let(:alive) { TableView::Plays::ALIVE }
  let(:dead) { TableView::Plays::DEAD }

  describe '#isAlive' do
    context 'Any alive cell with fewer than two alive neighbours dies' do
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 0)).to be TableView::Plays::DEAD }
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 1)).to be TableView::Plays::DEAD }
    end
    context 'Any alive cell with two or three alive neighbours lives on to the next generation' do
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 2)).to be TableView::Plays::ALIVE }
      it { expect(grid.is_alive(TableView::Plays::ALIVE, 3)).to be TableView::Plays::ALIVE }
    end
    context 'Any dead cell without 3 alive neighbours stay dead' do
      it { expect(grid.is_alive(TableView::Plays::DEAD, 2)).to be TableView::Plays::DEAD }
    end
    context 'Any dead cell with exactly three alive neighbours becomes a living cell' do
      it { expect(grid.is_alive(TableView::Plays::DEAD, 3)).to be TableView::Plays::ALIVE }
    end
    context 'Any alive cell with more than three alive neighbours die' do
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

  describe '==' do
    context 'simple equality' do
      it do
        expect(new_grid == grid).to be true
        expect(grid == grid).to be true
        expect(new_grid == new_grid).to be true
      end
    end
    context 'wrong dimension' do
      it { expect(new_grid == fake_grid).to be false }
      it { expect(new_grid == wrong_grid).to be false }
    end
    context 'wrong matrix' do
      before do
        grid.add_cell(4, 5, alive)
        grid.add_cell(5, 4, alive)
        grid.add_cell(5, 5, alive)
        grid.add_cell(5, 6, alive)
        grid.add_cell(6, 5, alive)
      end
      it { expect(new_grid == grid).to be false }
    end
  end

  describe '#count' do
    context 'one alive cells' do
      before do
        one_cells_grid.add_cell(1, 1, alive)
      end
      it { expect(one_cells_grid.count(alive)).to eq 1 }
      it { expect(one_cells_grid.count(dead)).to eq 0 }
    end
    context 'one dead cells' do
      before do
        one_cells_grid.add_cell(1, 1, dead)
      end
      it { expect(one_cells_grid.count(alive)).to eq 0 }
      it { expect(one_cells_grid.count(dead)).to eq 1 }
    end
    context 'big cells' do
      before do
        new_grid.add_cell(4, 5, alive)
        new_grid.add_cell(5, 4, alive)
        new_grid.add_cell(5, 5, alive)
        new_grid.add_cell(5, 6, alive)
        new_grid.add_cell(6, 5, alive)
      end
      it { expect(new_grid.count(alive)).to eq 5 }
      it { expect(new_grid.count(dead)).to eq 95 }
    end
  end
end

