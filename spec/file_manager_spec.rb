require 'rspec'

require_relative '../lib/file_manager'
require_relative '../lib/grid'

describe FileManager do
  let(:file_manager) { FileManager.new }
  let(:empty_grid) { file_manager.format_grid(Grid.new(10, 5)) }

  describe '#create' do
    it "should create 'filename' and put formatted grid in json in it" do
      file = double('file')
      expect(File).to receive(:open).with("filename_100", "w").and_yield(file)
      expect(file).to receive(:write).with("{\"length\":10,\"height\":5,\"cells\":{}}")
      file_manager.save(empty_grid.to_json, 100)
    end
  end

  describe '#getGrid' do
    it "should get grid from 'filename'" do
      expect(File).to receive(:open).with("filename_100", "r")
      file_manager.getGrid(100)
    end
  end
end
