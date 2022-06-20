require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/pawn'
# rspec spec/pawn_spec.rb

describe Pawn do
  subject(:white_pawn) { described_class.new('White') }
  subject(:black_pawn) { described_class.new('Black') }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        start = [3, 3]
        fin = [2, 3]
        expect { white_pawn.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♟')
      end

      it 'removes pieces from original spot' do
        start = [3, 3]
        fin = [2, 3]
        gameboard.grid[start[0]][start[1]] = '♟'
        expect { white_pawn.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♟').to(' ')
      end
    end

    context 'space is not empty' do
      xit 'takes enemy piece' do
        start = [3, 3]
        fin = [2, 3]
        gameboard.grid[2][3] = '♙'
        expect { white_pawn.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♙').to('♟')
      end

      it 'doesnt go to the space' do
        start = [3, 3]
        fin = [2, 3]
        gameboard.grid[2][3] = '♟'
        expect { white_pawn.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'movement is valid' do
      it 'returns true(+1/0)' do
        start = [0, 0]
        fin = [1, 0]
        expect(black_pawn.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/0)' do
        start = [5, 5]
        fin = [4, 5]
        expect(white_pawn.valid_move?(start, fin)).to be true
      end
    end

    context 'movement is invalid' do
      it 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(white_pawn.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(white_pawn.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false' do
        start_x = 3
        start_y = 3
        fin_x = 5
        fin_y = 4
        expect(white_pawn.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end
    end
  end
end
