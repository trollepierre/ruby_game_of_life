require 'rspec'

require_relative '../lib/table_view'
require_relative '../lib/grid'

describe TableView do
  let(:table) { TableView.new }
  let(:empty_grid) { Grid.new(3, 4) }
  let(:grid) { Grid.new(3, 4) }
  let(:alive) { "alive" }
  let(:dead) { "dead" }

  describe '#display' do
    context 'empty grid' do
      it { expect(table.display(empty_grid,1)).to eq expected }
      let(:expected) do
        <<EOS


Grille au tour 1 :
. . .
. . .
. . .
. . .
EOS
      end

    end
    context 'one cell grid' do
      before do
        grid.add_cell(2, 2, alive)
      end
      it { expect(table.display(grid,1)).to eq expected }
      let(:expected) do
        <<EOS


Grille au tour 1 :
. . .
. * .
. . .
. . .
EOS
      end
    end
    context 'two cells grid' do
      before do
        grid.add_cell(2, 2, alive)
        grid.add_cell(2, 4, alive)
      end
      it { expect(table.display(grid,1)).to eq expected }
      let(:expected) do
        <<EOS


Grille au tour 1 :
. . .
. * .
. . .
. * .
EOS
      end
    end
  end
end
