require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/knight'
# rspec spec/knight_spec.rb

describe Knight do
  subject(:knight) { described_class.new('White', [0, 1]) }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        start = [3, 3]
        fin = [5, 4]
        expect { knight.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♞')
      end

      it 'removes pieces from original spot' do
        start = [3, 3]
        fin = [5, 4]
        gameboard.grid[start[0]][start[1]] = '♞'
        expect { knight.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♞').to(' ')
      end
    end

    context 'space is not empty' do
      it 'takes enemy piece' do
        start = [4, 2]
        fin = [2, 3]
        gameboard.grid[2][3] = '♘'
        expect { knight.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♘').to('♞')
      end

      it 'doesnt go to the space' do
        start = [4, 2]
        fin = [2, 3]
        gameboard.grid[2][3] = '♞'
        expect { knight.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'movement is valid' do
      it 'returns true(+1/+2)' do
        start = [0, 0]
        fin = [1, 2]
        expect(knight.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/-2)' do
        start = [5, 5]
        fin = [4, 3]
        expect(knight.valid_move?(start, fin)).to be true
      end

      it 'returns true(+1/-2)' do
        start = [0, 5]
        fin = [1, 3]
        expect(knight.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/+2)' do
        start = [5, 0]
        fin = [4, 2]
        expect(knight.valid_move?(start, fin)).to be true
      end

      it 'returns true(-2/+1)' do
        start = [5, 0]
        fin = [3, 1]
        expect(knight.valid_move?(start, fin)).to be true
      end

      it 'returns true(+2/-1)' do
        start = [3, 3]
        fin = [5, 2]
        expect(knight.valid_move?(start, fin)).to be true
      end

      it 'returns true(-2/-1)' do
        start = [5, 5]
        fin = [3, 4]
        expect(knight.valid_move?(start, fin)).to be true
      end

      it 'returns true(+2/+1)' do
        start = [0, 0]
        fin = [2, 1]
        expect(knight.valid_move?(start, fin)).to be true
      end
    end

    context 'movement is invalid' do
      it 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(knight.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(knight.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false' do
        start_x = 3
        start_y = 3
        fin_x = 5
        fin_y = 5
        expect(knight.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end
    end
  end

  describe '#attacking_square?' do
    context 'when spot is in legal range' do
      it 'returns true' do
        x = 4
        y = 2
        gameboard.grid[6][3] = '♞'
        expect(knight.attacking_square?(gameboard, [x, y])).to be true
      end

      it 'returns true' do
        x = 0
        y = 0
        gameboard.grid[1][2] = '♞'
        expect(knight.attacking_square?(gameboard, [x, y])).to be true
      end
    end

    context 'when spot is not in legal range' do
      it 'returns false' do
        x = 0
        y = 0
        expect(knight.attacking_square?(gameboard, [x, y])).to be false
      end
    end
  end
end
