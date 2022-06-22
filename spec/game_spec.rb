require './lib/game'
require './lib/board'
require './lib/player'
# rspec spec/game_spec.rb

describe Game do
  subject(:game) { described_class.new }
  subject(:board) { described_class.new }
  subject(:player1) { double(Player) }
  subject(:player2) { double(Player) }

  describe '#check?' do
    context 'when king is in check' do
      it 'returns true' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][1] = '♕'
        game.turn.pieces[:king].location = [0, 0]
        expect(game.check?).to be true
      end
    end

    context 'when king isnt in check' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].location = [0, 0]
        expect(game.check?).to be false
      end
    end

    context 'if moving to a discovered space' do
      it 'returns true' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][2] = '♕'
        game.turn.pieces[:king].location = [0, 0]
        game.turn.pieces[:king].move_king(game.board, [0, 0], [0, 1])
        expect(game.check?).to be true
      end
    end

    context 'if moving to an undiscovered space' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].location = [0, 0]
        game.turn.pieces[:king].move_king(game.board, [0, 0], [0, 1])
        expect(game.check?).to be false
      end
    end
  end
end
