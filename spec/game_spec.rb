require './lib/game'
require './lib/board'
require './lib/player'
# rspec spec/game_spec.rb

describe Game do
  subject(:game) { described_class.new }

  describe '#spot_being_attacked?' do
    context 'when spot is being attacked' do
      it 'returns true' do
        spot = [3, 3]
        game.board.grid[2][2] = '♕'
        expect(game.spot_being_attacked?(spot)).to be true
      end
    end

    context 'when spot is not being attacked' do
      it 'returns false' do
        spot = [3, 3]
        game.board.grid[5][2] = '♛'
        expect(game.spot_being_attacked?(spot)).to be false
      end
    end
  end

  describe '#check?' do
    context 'when king is in check' do
      it 'returns true' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][1] = '♕'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.check?).to be true
      end
    end

    context 'when king isnt in check' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.check?).to be false
      end

      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.check?).to be false
      end

      it 'returns false' do
        game.board.grid[7][3] = '♚'
        game.board.grid[0][4] = '♕'
        game.player2.pieces[:queen].position = [0, 4]
        game.player1.pieces[:king].position = [7, 3]
        expect(game.check?).to be false
      end
    end

    context 'if moving to a discovered space' do
      it 'returns true' do
        game.board.grid[0][3] = '♚'
        game.board.grid[1][7] = '♕'
        game.turn.pieces[:king].move(game.board, [0, 3], [1, 4])
        expect(game.check?).to be true
      end
    end

    context 'if moving to an undiscovered space' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].move(game.board, [0, 0], [0, 1])
        expect(game.check?).to be false
      end
    end
  end

  describe '#checkmate' do
    context 'when king has no escape' do
      it 'returns true' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][0] = '♞'
        game.board.grid[1][1] = '♞'
        game.board.grid[0][2] = '♕'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.checkmate?).to be true
      end
    end

    context 'when king has an escape' do
      it 'returns false' do
        game.board.grid[0][0] = '♚'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.checkmate?).to be false
      end
    end

    context 'when another piece can save the king' do
      xit 'returns false(eating)' do
        game.board.grid[0][0] = '♚'
        game.board.grid[1][0] = '♞'
        game.board.grid[1][1] = '♞'
        game.board.grid[0][2] = '♕'
        game.board.grid[2][2] = '♞'
        game.turn.pieces[:king].position = [0, 0]
        expect(game.checkmate?).to be false
      end

      xit 'returns false(blocking)' do
      end
    end
  end
end
