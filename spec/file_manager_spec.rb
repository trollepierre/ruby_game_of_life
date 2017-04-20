require 'rspec'
require 'rspec/mocks'

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
    describe "file is correctly open" do
      before() do
        @file = double('file')
        allow(File).to receive(:open).with("data/filename_100", "w").and_return(@file)
        allow(@file).to receive(:write).with(empty_grid.to_json)
        allow(@file).to receive(:close)
      end
      it "should open with correct file path and mode" do
        expect(File).to receive(:open).with("data/filename_100", "w")
        file_manager.save(empty_grid.to_json, 100)
      end
      it "should write grid in file" do
        expect(@file).to receive(:write).with(empty_grid.to_json)
        file_manager.save(empty_grid.to_json, 100)
      end
      it "should close the file" do
        expect(@file).to receive(:close)
        file_manager.save(empty_grid.to_json, 100)
      end
    end
    describe "when error occurs during read" do
      before() do
        @file = double('file')
        allow(File).to receive(:open).with("data/filename_100", "w").and_raise('err')
      end
      it "should open with correct file path and mode" do
        expect(file_manager.save(empty_grid.to_json, 100)).to eq "Exception: err"
      end
    end
  end

  describe '#readFile' do
    describe "file is correctly open" do
      before() do
        @file = double('file')
        allow(File).to receive(:open).with("data/filename_100", "r").and_return(@file)
        allow(@file).to receive(:read).and_return("content")
        allow(@file).to receive(:close)
      end
      it "should open with correct file path and mode" do
        expect(File).to receive(:open).with("data/filename_100", "r")
        file_manager.readFile(100)
      end
      it "should read content" do
        expect(@file).to receive(:read)
        file_manager.readFile(100)
      end
      it "should close file" do
        expect(@file).to receive(:close)
        file_manager.readFile(100)
      end
      it "should return content" do
        expect(file_manager.readFile(100)).to eq "content"
      end
    end
    describe "when error occurs during read" do
      before() do
        @file = double('file')
        allow(File).to receive(:open).with("data/filename_100", "r").and_raise('err')
      end
      it "should open with correct file path and mode" do
        expect(file_manager.readFile(100)).to eq "Exception: err"
      end
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
