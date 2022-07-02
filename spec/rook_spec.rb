require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/rook'
# rspec spec/rook_spec.rb

describe Rook do
  subject(:rook) { described_class.new('White', [0, 0]) }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        start = [3, 3]
        fin = [0, 3]
        expect { rook.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♜')
      end

      it 'removes pieces from original spot' do
        start = [3, 3]
        fin = [0, 3]
        gameboard.grid[start[0]][start[1]] = '♜'
        expect { rook.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♜').to(' ')
      end
    end

    context 'space is not empty' do
      it 'takes enemy piece' do
        start = [3, 3]
        fin = [0, 3]
        gameboard.grid[0][3] = '♖'
        expect { rook.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♖').to('♜')
      end

      it 'doesnt go to the space' do
        start = [3, 3]
        fin = [0, 3]
        gameboard.grid[0][3] = '♜'
        expect { rook.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'movement is valid' do
      it 'returns true(+1/0)' do
        start = [0, 0]
        fin = [5, 0]
        expect(rook.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/0)' do
        start = [5, 0]
        fin = [0, 0]
        expect(rook.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/+1)' do
        start = [0, 0]
        fin = [0, 5]
        expect(rook.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/-1)' do
        start = [0, 5]
        fin = [0, 0]
        expect(rook.valid_move?(start, fin)).to be true
      end
    end

    context 'movement is invalid' do
      it 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(rook.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(rook.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false' do
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
      it 'returns true' do
        x = 3
        y = 0
        gameboard.grid[5][0] = '♖'
        gameboard.grid[0][0] = '♜'
        expect(rook.attacking_square?(gameboard, [x, y])).to be true
      end

      it 'returns true' do
        x = 0
        y = 0
        gameboard.grid[0][5] = '♖'
        gameboard.grid[0][3] = '♜'
        expect(rook.attacking_square?(gameboard, [x, y])).to be true
      end
    end

    context 'when spot is not in legal range' do
      it 'returns false' do
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

  describe '#find_path' do
    context 'when x is positive' do
      it 'returns path' do
        start = [1, 1]
        fin = [4, 1]
        path = [[2, 1], [3, 1]]
        expect(rook.find_path(start, fin)).to eq(path)
      end

      it 'returns path' do
        start = [1, 1]
        fin = [5, 1]
        path = [[2, 1], [3, 1], [4, 1]]
        expect(rook.find_path(start, fin)).to eq(path)
      end
    end

    context 'when x is negative' do
      it 'returns path' do
        start = [4, 1]
        fin = [1, 1]
        path = [[3, 1], [2, 1]]
        expect(rook.find_path(start, fin)).to eq(path)
      end

      it 'returns path' do
        start = [6, 1]
        fin = [1, 1]
        path = [[5, 1], [4, 1], [3, 1], [2, 1]]
        expect(rook.find_path(start, fin)).to eq(path)
      end
    end

    context 'when y is positive' do
      it 'returns path' do
        start = [7, 0]
        fin = [7, 3]
        path = [[7, 1], [7, 2]]
        expect(rook.find_path(start, fin)).to eq(path)
      end

      it 'returns path' do
        start = [3, 4]
        fin = [3, 7]
        path = [[3, 5], [3, 6]]
        expect(rook.find_path(start, fin)).to eq(path)
      end
    end

    context 'when y is negative' do
      it 'returns path' do
        start = [4, 6]
        fin = [4, 3]
        path = [[4, 5], [4, 4]]
        expect(rook.find_path(start, fin)).to eq(path)
      end

      it 'returns path' do
        start = [3, 4]
        fin = [3, 1]
        path = [[3, 3], [3, 2]]
        expect(rook.find_path(start, fin)).to eq(path)
      end
    end
  end
end
