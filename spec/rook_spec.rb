require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/rook'
# rspec spec/rook_spec.rb

describe Rook do
  subject(:rook) { described_class.new('White') }
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
end
