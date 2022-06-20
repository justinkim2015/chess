require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/king'
# rspec spec/king_spec.rb

describe King do
  subject(:king) { described_class.new('White') }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        start = [3, 3]
        fin = [4, 4]
        expect { king.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♚')
      end

      it 'removes pieces from original spot' do
        start = [3, 3]
        fin = [4, 4]
        gameboard.grid[start[0]][start[1]] = '♚'
        expect { king.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♚').to(' ')
      end
    end

    context 'space is not empty' do
      it 'takes enemy piece' do
        start = [4, 2]
        fin = [5, 3]
        gameboard.grid[5][3] = '♘'
        expect { king.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♘').to('♚')
      end

      it 'doesnt go to the space' do
        start = [4, 2]
        fin = [3, 2]
        gameboard.grid[3][2] = '♚'
        expect { king.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'movement is valid' do
      it 'returns true(+1/+1)' do
        start = [0, 0]
        fin = [1, 1]
        expect(king.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/-1)' do
        start = [5, 5]
        fin = [4, 4]
        expect(king.valid_move?(start, fin)).to be true
      end

      it 'returns true(+1/0)' do
        start = [0, 5]
        fin = [1, 5]
        expect(king.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/0)' do
        start = [5, 0]
        fin = [4, 0]
        expect(king.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/+1)' do
        start = [4, 0]
        fin = [3, 1]
        expect(king.valid_move?(start, fin)).to be true
      end

      it 'returns true(+1/-1)' do
        start = [3, 3]
        fin = [4, 2]
        expect(king.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/-1)' do
        start = [5, 5]
        fin = [5, 4]
        expect(king.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/+1)' do
        start = [0, 0]
        fin = [0, 1]
        expect(king.valid_move?(start, fin)).to be true
      end
    end

    context 'movement is invalid' do
      it 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(king.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(king.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false' do
        start_x = 3
        start_y = 3
        fin_x = 5
        fin_y = 5
        expect(king.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end
    end
  end
end
