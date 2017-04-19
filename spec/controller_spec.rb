require 'rspec'
require 'rspec/mocks'

require_relative '../lib/controller'
require_relative '../lib/file_manager'

describe Controller do
  let(:id_grid) { 100 }
  let(:file_manager) { FileManager.new }
  let(:controller) { Controller.new file_manager }

  describe '#sayHi' do
    it "should return Hello world" do
      expect(controller.sayHi).to eq "Hello, world!"
    end
  end

  describe '#getGrid' do
    it "should get id Grid" do
      id = 100
      expect(controller.getGrid(id)).to eq id
    end

    it "should return grid" do
      id = 100
      file_manager = double
      controller = Controller.new file_manager
      expect(file_manager).to receive(:getNotNullFormattedGridFromReadFile)

      controller.getGrid :id_grid
    end
  end
end
