require './lib/game'
# rspec spec/game_spec.rb

describe Game do
  subject(:game) { described_class.new }

  describe '#place_pieces' do
    it 'replaces empty appropriate spot with a piece' do
      piece = '♖'
      expect { game.place_pieces }.to change { board.grid[0][0] }.from(' ').to(piece)
    end
  end
end