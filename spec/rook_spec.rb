require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/rook'
# rspec spec/rook_spec.rb

describe Rook do
  subject(:rook) { described_class.new('Whxite', [0, 0]) }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      xit 'moves to empty space' do
        start = [3, 3]
        fin = [0, 3]
        expect { rook.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♜')
      end

      xit 'removes pieces from original spot' do
        start = [3, 3]
        fin = [0, 3]
        gameboard.grid[start[0]][start[1]] = '♜'
        expect { rook.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♜').to(' ')
      end
    end

    context 'space is not empty' do
      xit 'takes enemy piece' do
        start = [3, 3]
        fin = [0, 3]
        gameboard.grid[0][3] = '♖'
        expect { rook.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♖').to('♜')
      end

      xit 'doesnt go to the space' do
        start = [3, 3]
        fin = [0, 3]
        gameboard.grid[0][3] = '♜'
        expect { rook.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'movement is valid' do
      xit 'returns true(+1/0)' do
        start = [0, 0]
        fin = [5, 0]
        expect(rook.valid_move?(start, fin)).to be true
      end

      xit 'returns true(-1/0)' do
        start = [5, 0]
        fin = [0, 0]
        expect(rook.valid_move?(start, fin)).to be true
      end

      xit 'returns true(0/+1)' do
        start = [0, 0]
        fin = [0, 5]
        expect(rook.valid_move?(start, fin)).to be true
      end

      xit 'returns true(0/-1)' do
        start = [0, 5]
        fin = [0, 0]
        expect(rook.valid_move?(start, fin)).to be true
      end
    end

    context 'movement is invalid' do
      xit 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(rook.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      xit 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(rook.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      xit 'returns false' do
        start_x = 3
        start_y = 3
        fin_x = 5
        fin_y = 4
        expect(rook.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end
    end
  end

  describe '#attacking_square?' do
    context 'when spot is in legal range' do
      xit 'returns true' do
        x = 3
        y = 0
        gameboard.grid[5][0] = '♖'
        gameboard.grid[0][0] = '♜'
        expect(rook.attacking_square?(gameboard, [x, y])).to be true
      end

      xit 'returns true' do
        x = 0
        y = 0
        gameboard.grid[0][5] = '♖'
        gameboard.grid[0][3] = '♜'
        expect(rook.attacking_square?(gameboard, [x, y])).to be true
      end
    end

    context 'when spot is not in legal range' do
      xit 'returns false' do
        x = 0
        y = 0
        expect(rook.attacking_square?(gameboard, [x, y])).to be false
      end
    end

    context 'when spot is being blocked by another piece' do
      it 'returns false' do
        x = 3
        y = 0
        gameboard.grid[2][0] = '♖'
        gameboard.grid[1][0] = '♜'
        expect(rook.attacking_square?(gameboard, [x, y])).to be false
      end
    end
  end
end
