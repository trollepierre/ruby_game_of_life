require 'rspec'
require 'rspec/mocks'
# require 'mocha/setup'

require_relative '../lib/randomizer'
require_relative '../lib/grid'

describe Randomizer do
  let(:randomizer) { Randomizer.new }
  let(:dead_multicell_grid) { Grid.new(5, 5) }
  let(:alive_monocell_grid) do
    grid = Grid.new(1, 1)
    grid.add_cell(1, 1, TableView::Plays::ALIVE)
    return grid
  end

  it "should generate an alive monocell grid" do
    allow(randomizer).to receive(:halfChance).and_return(true)
    expect(randomizer.get_grid(1, 1)).to eq alive_monocell_grid
  end

  it "should generate an alive monocell grid" do
    allow(randomizer).to receive(:halfChance).and_return(false)
    expect(randomizer.get_grid(5, 5)).to eq dead_multicell_grid
  end
end

