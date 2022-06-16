require './lib/pieces/bishop'
require './lib/board'
require './lib/player'
# rspec /spec/bishop_spec.rb

describe Bishop do
  subject(:bishop) { described_class.new('White') }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        x = 0
        y = 0
        expect { bishop.move(gameboard, x, y) }.to change { gameboard.grid[x][y] }.from(' ').to('♝')
      end
    end
  end
end

# allow(board).to receive(:grid) {
#   [[[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']],
#    [[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']],
#    [[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']],
#    [[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']],
#    [[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']],
#    [[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']],
#    [[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']],
#    [[' '], [' '], [' '], [' '], [' '], [' '], [' '], [' ']]]
# }
