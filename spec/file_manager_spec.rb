require 'rspec'

require_relative '../lib/file_manager'
require_relative '../lib/grid'
require_relative '../lib/table_view'

describe FileManager do
  let(:alive) { TableView::Plays::ALIVE }
  let(:file_manager) { FileManager.new }
  let(:empty_grid) { file_manager.format_grid(Grid.new(10, 5)) }
  let(:small_empty_grid) { Grid.new(1, 1) }
  let(:two_cells_empty_grid) { Grid.new(2, 1) }
  let(:square_grid) { Grid.new(2, 2) }
  let(:small_filled_grid) do
    grid = Grid.new(1, 1)
    grid.add_cell(1, 1, alive)
    return grid
  end

  describe '#save' do
    it "should create 'filename' and put formatted grid in json in it" do
      file = double('file')
      expect(File).to receive(:open).with("filename_100", "w").and_yield(file)
      expect(file).to receive(:write).with("{\"length\":10,\"height\":5,\"cells\":{}}")
      file_manager.save(empty_grid.to_json, 100)
    end
  end

  describe '#readFile' do
    it "should get grid from 'filename'" do
      expect(File).to receive(:open).with("filename_100", "r")
      file_manager.readFile(100)
    end
  end

  describe '#new_format_grid' do
    it 'should format a small empty grid' do
      expect(file_manager.new_format_grid(small_empty_grid)).to eq('[{"x":1,"y":1,"state":"dead"}]')
    end
    it 'should format a small filled grid' do
      expect(file_manager.new_format_grid(small_filled_grid)).to eq('[{"x":1,"y":1,"state":"alive"}]')
    end
    it 'should format a two cells empty  grid' do
      expect(file_manager.new_format_grid(two_cells_empty_grid)).to eq('[{"x":1,"y":1,"state":"dead"},{"x":2,"y":1,"state":"dead"}]')
    end
    it 'should format a square empty grid' do
      expect(file_manager.new_format_grid(square_grid)).to eq('[{"x":1,"y":1,"state":"dead"},{"x":1,"y":2,"state":"dead"},{"x":2,"y":1,"state":"dead"},{"x":2,"y":2,"state":"dead"}]')
    end
  end

  describe '#reformat_grid' do
    it 'should reformat small empty grid' do
      expect(file_manager.reformat_grid('[{"x":1,"y":1,"state":"dead"}]')).to eq(small_empty_grid)
    end
    it 'should reformat a small filled grid' do
      expect(file_manager.reformat_grid('[{"x":1,"y":1,"state":"alive"}]')).to eq(small_filled_grid)
    end
    it 'should format a two cells empty  grid' do
      expect(file_manager.reformat_grid('[{"x":1,"y":1,"state":"dead"},{"x":2,"y":1,"state":"dead"}]')).to eq(two_cells_empty_grid)
    end
    it 'should format a square empty grid' do
      expect(file_manager.reformat_grid('[{"x":1,"y":1,"state":"dead"},{"x":1,"y":2,"state":"dead"},{"x":2,"y":1,"state":"dead"},{"x":2,"y":2,"state":"dead"}]')).to eq(square_grid)
    end
  end
end
