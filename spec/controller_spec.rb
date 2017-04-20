require 'rspec'
require 'rspec/mocks'

require_relative '../lib/controller'
require_relative '../lib/file_manager'
require_relative '../lib/grid'
require_relative '../lib/randomizer'

describe Controller do
  let(:id_grille) { "100" }
  let(:height) { 50 }
  let(:width) { 10 }
  let(:file_manager) { FileManager.new }
  let(:randomizer) { Randomizer.new }
  let(:controller) { Controller.new @file_manager, @randomizer }

  describe '#sayHi' do
    it "should return Hello world" do
      expect(controller.sayHi).to eq "Hello, world!"
    end
  end

  describe '#getGrid' do
    before(:each) do
      @file_manager = double
      @grid = double
      @next_grid = double
      @grid_to_json = double
      @controller = Controller.new @file_manager, @randomizer

      allow(@file_manager).to receive(:getNotNullFormattedGridFromReadFile).with(:id_grille).and_return(@grid)
      allow(@grid).to receive(:next).and_return(@next_grid)
      allow(@file_manager).to receive(:new_format_grid).and_return(@grid_to_json)
      allow(@file_manager).to receive(:save)
    end

    it "should call file manager with correct id grille" do
      expect(@file_manager).to receive(:getNotNullFormattedGridFromReadFile).with(:id_grille)
      @controller.getGrid :id_grille
    end

    it "should call next grid" do
      expect(@grid).to receive(:next)
      @controller.getGrid :id_grille
    end

    it "should format new grid with next grid" do
      expect(@file_manager).to receive(:new_format_grid).with(@next_grid)
      @controller.getGrid :id_grille
    end

    it "should save grid to json" do
      expect(@file_manager).to receive(:save).with(@grid_to_json, :id_grille)
      @controller.getGrid :id_grille
    end

    it "should return grid to json" do
      expect(@controller.getGrid(:id_grille)).to eq @grid_to_json
    end
  end

  describe '#count_cells' do
    before(:each) do
      @file_manager = double
      @randomizer = double
      @grid = double
      @controller = Controller.new @file_manager, @randomizer

      allow(@file_manager).to receive(:getNotNullFormattedGridFromReadFile).and_return(@grid)
      allow(@grid).to receive(:count).with(TableView::Plays::ALIVE).and_return(345)
      allow(@grid).to receive(:count).with(TableView::Plays::DEAD).and_return(28)
    end

    it "should return grid count into string" do
      expect(@controller.count_cells(:id_grille, 'alive')).to eq "345"
    end

    it "should return grid count of dead cells into string" do
      expect(@controller.count_cells(:id_grille, 'dead')).to eq "28"
    end

    it "should return grid count of dead cells into string" do
      expect(@controller.count_cells(:id_grille, 'fakeString')).to eq "345"
    end

    it "should count cells with params id and alive" do
      expect(@grid).to receive(:count) { TableView::Plays::ALIVE }
      @controller.count_cells :id_grille, 'alive'
    end

    it "should call file manager with correct id grille" do
      expect(@file_manager).to receive(:getNotNullFormattedGridFromReadFile).with(:id_grille)
      @controller.count_cells :id_grille, 'alive'
    end
  end

  describe '#create_grid' do
    before(:each) do
      @file_manager = double
      @randomizer = double
      @grid_to_json = double
      @grid = Grid.new(50, 10)
      @controller = Controller.new @file_manager, @randomizer

      allow(@file_manager).to receive(:new_format_grid).and_return(@grid_to_json)
      allow(@file_manager).to receive(:save)
      allow(@randomizer).to receive(:get_grid).with(50, 10).and_return(@grid)
    end

    it "should return grid to json" do
      expect(@controller.create_grid("100", "50", "10")).to eq @grid_to_json
    end

    it "should new format grid with a new grid with correct length and width" do
      expect(@file_manager).to receive(:new_format_grid).with(@grid)
      @controller.create_grid("100", "50", "10")
    end

    it "should save grid to json" do
      expect(@file_manager).to receive(:save).with(@grid_to_json, "100")
      @controller.create_grid("100", "50", "10")
    end

    it "should call random grid" do
      expect(@randomizer).to receive(:get_grid).with(50, 10)
      @controller.create_grid("100", "50", "10")
    end
  end
end
