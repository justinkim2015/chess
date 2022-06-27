require './lib/pieces/queen'
require './lib/board'
require './lib/player'
require './lib/pieces/piece'
# rspec spec/queen_spec.rb

describe Queen do
  subject(:queen) { described_class.new('White', [0, 4]) }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        start = [3, 3]
        fin = [0, 0]
        expect { queen.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♛')
      end

      it 'removes pieces from original spot' do
        start = [3, 3]
        fin = [0, 0]
        gameboard.grid[start[0]][start[1]] = '♛'
        expect { queen.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♛').to(' ')
      end
    end

    context 'space is not empty' do
      it 'takes enemy piece' do
        start = [3, 3]
        fin = [0, 0]
        gameboard.grid[0][0] = '♗'
        expect { queen.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♗').to('♛')
      end

      it 'doesnt go to the space' do
        start = [3, 3]
        fin = [0, 0]
        gameboard.grid[0][0] = '♛'
        expect { queen.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'movement is valid' do
      it 'returns true(+1/+1)' do
        start_x = 0
        start_y = 0
        fin_x = 5
        fin_y = 5
        expect(queen.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end

      it 'returns true(-1/-1)' do
        start_x = 5
        start_y = 5
        fin_x = 0
        fin_y = 0
        expect(queen.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end

      it 'returns true(+1/-1)' do
        start_x = 4
        start_y = 4
        fin_x = 6
        fin_y = 2
        expect(queen.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end

      it 'returns true(-1/+1)' do
        start_x = 4
        start_y = 4
        fin_x = 1
        fin_y = 7
        expect(queen.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end

      it 'returns true(+1/0)' do
        start = [0, 5]
        fin = [5, 5]
        expect(queen.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/0)' do
        start = [5, 0]
        fin = [0, 0]
        expect(queen.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/-1)' do
        start = [5, 5]
        fin = [5, 0]
        expect(queen.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/+1)' do
        start = [0, 0]
        fin = [0, 5]
        expect(queen.valid_move?(start, fin)).to be true
      end
    end

    context 'movement is invalid' do
      it 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(queen.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(queen.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false' do
        start_x = 3
        start_y = 3
        fin_x = 5
        fin_y = 4
        expect(queen.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end
    end
  end

  describe '#valid_spot?' do
    context 'when spot is empty' do
      it 'returns true' do
        x = 0
        y = 0
        expect(queen.valid_spot?(gameboard, [x, y])).to be true
      end
    end

    context 'when spot is not empty' do
      it 'returns false' do
        x = 0
        y = 0
        gameboard.grid[0][0] = '♛'
        expect(queen.valid_spot?(gameboard, [x, y])).to be false
      end
    end
  end

  describe '#attacking_square?' do
    context 'when spot is in legal range' do
      it 'returns true' do
        x = 3
        y = 0
        gameboard.grid[5][0] = '♕'
        gameboard.grid[0][0] = '♛'
        expect(queen.attacking_square?(gameboard, [x, y])).to be true
      end

      it 'returns true' do
        x = 4
        y = 4
        gameboard.grid[5][5] = '♕'
        gameboard.grid[0][0] = '♛'
        expect(queen.attacking_square?(gameboard, [x, y])).to be true
      end

      it 'returns true' do
        x = 0
        y = 0
        gameboard.grid[0][5] = '♕'
        gameboard.grid[0][3] = '♛'
        expect(queen.attacking_square?(gameboard, [x, y])).to be true
      end
    end

    context 'when spot is not in legal range' do
      it 'returns false' do
        x = 0
        y = 0
        expect(queen.attacking_square?(gameboard, [x, y])).to be false
      end
    end

    context 'when spot is being blocked by another piece' do
      it 'returns false' do
        x = 3
        y = 0
        gameboard.grid[2][0] = '♕'
        gameboard.grid[1][0] = '♛'
        expect(queen.attacking_square?(gameboard, [x, y])).to be false
      end

      it 'returns false' do
        x = 4
        y = 4
        gameboard.grid[2][2] = '♕'
        gameboard.grid[0][0] = '♛'
        expect(queen.attacking_square?(gameboard, [x, y])).to be false
      end
    end
  end
end
