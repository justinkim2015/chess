require './lib/pieces/bishop'
require './lib/board'
require './lib/player'
require './lib/pieces/piece'
# rspec spec/bishop_spec.rb

describe Bishop do
  subject(:bishop) { described_class.new('White', [0, 2]) }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        start = [3, 3]
        fin = [0, 0]
        expect { bishop.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♝')
      end

      it 'removes pieces from original spot' do
        start = [3, 3]
        fin = [0, 0]
        gameboard.grid[start[0]][start[1]] = '♝'
        expect { bishop.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♝').to(' ')
      end
    end

    context 'space is not empty' do
      it 'takes enemy piece' do
        start = [3, 3]
        fin = [0, 0]
        gameboard.grid[0][0] = '♗'
        expect { bishop.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♗').to('♝')
      end

      it 'doesnt go to the space' do
        start = [3, 3]
        fin = [0, 0]
        gameboard.grid[0][0] = '♝'
        expect { bishop.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
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
        expect(bishop.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end

      it 'returns true(-1/-1)' do
        start_x = 5
        start_y = 5
        fin_x = 0
        fin_y = 0
        expect(bishop.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end

      it 'returns true(+1/-1)' do
        start_x = 4
        start_y = 4
        fin_x = 6
        fin_y = 2
        expect(bishop.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end

      it 'returns true(-1/+1)' do
        start_x = 4
        start_y = 4
        fin_x = 1
        fin_y = 7
        expect(bishop.valid_move?([start_x, start_y], [fin_x, fin_y])).to be true
      end
    end

    context 'movement is invalid' do
      it 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(bishop.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(bishop.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false' do
        start_x = 3
        start_y = 3
        fin_x = 5
        fin_y = 4
        expect(bishop.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end
    end
  end

  describe '#valid_spot?' do
    context 'when spot is empty' do
      it 'returns true' do
        x = 0
        y = 0
        expect(bishop.valid_spot?(gameboard, [x, y])).to be true
      end
    end

    context 'when spot is not empty' do
      it 'returns false' do
        x = 0
        y = 0
        gameboard.grid[0][0] = '♝'
        expect(bishop.valid_spot?(gameboard, [x, y])).to be false
      end
    end
  end

  describe '#attacking_square?' do
    context 'when spot is in legal range' do
      it 'returns true' do
        x = 4
        y = 4
        gameboard.grid[5][5] = '♗'
        gameboard.grid[0][0] = '♝'
        expect(bishop.attacking_square?(gameboard, [x, y])).to be true
      end
    end

    context 'when spot is not in legal range' do
      it 'returns false' do
        x = 0
        y = 0
        expect(bishop.attacking_square?(gameboard, [x, y])).to be false
      end
    end

    context 'when spot is being blocked by another piece' do
      it 'returns false' do
        x = 4
        y = 4
        gameboard.grid[2][2] = '♗'
        gameboard.grid[0][0] = '♝'
        expect(bishop.attacking_square?(gameboard, [x, y])).to be false
      end
    end
  end
end
