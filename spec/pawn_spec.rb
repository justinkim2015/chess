require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/pawn'
# rspec spec/pawn_spec.rb

describe Pawn do
  subject(:white_pawn) { described_class.new('White', [1, 0]) }
  subject(:black_pawn) { described_class.new('Black', [6, 0]) }
  subject(:gameboard) { Board.new }

  describe '#move_pawn' do
    context 'space is empty' do
      it 'move_pawns to empty space' do
        start = [3, 3]
        fin = [2, 3]
        expect { white_pawn.move_pawn(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♟')
      end

      it 'remove_pawns pieces from original spot' do
        start = [3, 3]
        fin = [2, 3]
        gameboard.grid[start[0]][start[1]] = '♟'
        expect { white_pawn.move_pawn(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♟').to(' ')
      end
    end

    context 'space is not empty' do
      it 'takes enemy piece' do
        start = [3, 3]
        fin = [2, 2]
        gameboard.grid[2][2] = '♙'
        expect { white_pawn.move_pawn(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♙').to('♟')
      end

      it 'doesnt go to to space with ally' do
        start = [3, 3]
        fin = [2, 3]
        gameboard.grid[2][3] = '♟'
        expect { white_pawn.move_pawn(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end

      it 'doesnt eat directly in front' do
        start = [3, 3]
        fin = [2, 3]
        gameboard.grid[2][3] = '♙'
        expect { white_pawn.move_pawn(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'move_pawnment is valid' do
      it 'returns true(+1/0)' do
        start = [0, 0]
        fin = [1, 0]
        expect(black_pawn.valid_move?(gameboard, start, fin)).to be true
      end

      it 'returns true(-1/0)' do
        start = [5, 5]
        fin = [4, 5]
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be true
      end

      it 'eats piece diagonally forward' do
        start = [5, 5]
        fin = [4, 4]
        gameboard.grid[4][4] = '♙'
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be true
      end

      it 'eats piece diagonally forward' do
        start = [5, 1]
        fin = [4, 0]
        gameboard.grid[4][0] = '♙'
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be true
      end
    end

    context 'move_pawnment is invalid' do
      it 'returns false if out of bounds' do
        start = [0, 1]
        fin = [9, 9]
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be false
      end

      it 'returns false if the same' do
        start = [3, 3]
        fin = [3, 3]
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be false
      end

      it 'returns false' do
        start = [3, 3]
        fin = [5, 4]
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be false
      end

      it 'doesnt eat piece diagonally backwards' do
        start = [3, 3]
        fin = [4, 4]
        gameboard.grid[4][4] = '♙'
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be false
      end

      it 'doesnt eat directly in front' do
        start = [3, 3]
        fin = [2, 3]
        gameboard.grid[2][3] = '♙'
        expect(white_pawn.valid_move?(gameboard, start, fin)).to be false
      end
    end
  end

  describe '#move_forward' do
    it 'returns false when path is blocked' do
      start = [3, 3]
      fin = [2, 3]
      gameboard.grid[2][3] = '♙'
      expect(white_pawn.move_forward(gameboard, start, fin)).to be false
    end
  end

  describe '#eat_diag' do
    it 'returns false when path is blocked' do
      start = [3, 3]
      fin = [2, 3]
      gameboard.grid[2][3] = '♙'
      expect(white_pawn.eat_diag(gameboard, start, fin)).to be false
    end

    it 'eats piece diagonally forward' do
      start = [5, 1]
      fin = [4, 0]
      gameboard.grid[4][0] = '♙'
      expect(white_pawn.eat_diag(gameboard, start, fin)).to be true
    end
  end

  describe '#move_two' do
    context 'when piece is in original spot' do
      it 'can move two spaces(black)' do
        start = [1, 0]
        fin = [3, 0]
        expect(black_pawn.move_two(gameboard, start, fin)).to be true
      end

      it 'can move two spaces(white)' do
        start = [6, 3]
        fin = [4, 3]
        expect(white_pawn.move_two(gameboard, start, fin)).to be true
      end

    end
  end
end
