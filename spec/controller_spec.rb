require 'rspec'
require 'rspec/mocks'

require_relative '../lib/controller'
require_relative '../lib/file_manager'
require_relative '../lib/grid'

describe Controller do
  let(:id_grille) { 100 }
  let(:file_manager) { FileManager.new }
  let(:controller) { Controller.new file_manager }

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
      @controller = Controller.new @file_manager

      allow(@file_manager).to receive(:getNotNullFormattedGridFromReadFile).and_return(@grid)
      allow(@grid).to receive(:next).and_return(@next_grid)
      allow(@file_manager).to receive(:new_format_grid).and_return(@grid_to_json)
      allow(@file_manager).to receive(:save)
    end

    it "should call file manager with correct id grille" do
      expect(@file_manager).to receive(:getNotNullFormattedGridFromReadFile) { :id_grille }
      @controller.getGrid :id_grille
    end

    it "should call next grid" do
      expect(@grid).to receive(:next)
      @controller.getGrid :id_grille
    end

    it "should format new grid with next grid" do
      expect(@file_manager).to receive(:new_format_grid) { @next_grid }
      @controller.getGrid :id_grille
    end

    it "should save grid to json" do
      expect(@file_manager).to receive(:save) { @grid_to_json }
      @controller.getGrid :id_grille
    end

    it "should return grid to json" do
      expect(@controller.getGrid(:id_grille)).to eq @grid_to_json
    end
  end
end
