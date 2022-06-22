require './lib/board'
require './lib/player'
require './lib/pieces/piece'
require './lib/pieces/king'
# rspec spec/king_spec.rb

describe King do
  subject(:white_king) { described_class.new('White') }
  subject(:black_king) { described_class.new('Black') }
  subject(:gameboard) { Board.new }

  describe '#move' do
    context 'space is empty' do
      it 'moves to empty space' do
        start = [3, 3]
        fin = [4, 4]
        expect { white_king.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from(' ').to('♚')
      end

      it 'removes pieces from original spot' do
        start = [3, 3]
        fin = [4, 4]
        gameboard.grid[start[0]][start[1]] = '♚'
        expect { white_king.move(gameboard, start, fin) }.to change { gameboard.grid[start[0]][start[1]] }.from('♚').to(' ')
      end
    end

    context 'space is not empty' do
      it 'takes enemy piece' do
        start = [4, 2]
        fin = [5, 3]
        gameboard.grid[5][3] = '♘'
        expect { white_king.move(gameboard, start, fin) }.to change { gameboard.grid[fin[0]][fin[1]] }.from('♘').to('♚')
      end

      it 'doesnt go to the space' do
        start = [4, 2]
        fin = [3, 2]
        gameboard.grid[3][2] = '♚'
        expect { white_king.move(gameboard, start, fin) }.not_to change { gameboard.grid[fin[0]][fin[1]] }
      end
    end
  end

  describe '#valid_move?' do
    context 'movement is valid' do
      it 'returns true(+1/+1)' do
        start = [0, 0]
        fin = [1, 1]
        expect(white_king.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/-1)' do
        start = [5, 5]
        fin = [4, 4]
        expect(white_king.valid_move?(start, fin)).to be true
      end

      it 'returns true(+1/0)' do
        start = [0, 5]
        fin = [1, 5]
        expect(white_king.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/0)' do
        start = [5, 0]
        fin = [4, 0]
        expect(white_king.valid_move?(start, fin)).to be true
      end

      it 'returns true(-1/+1)' do
        start = [4, 0]
        fin = [3, 1]
        expect(white_king.valid_move?(start, fin)).to be true
      end

      it 'returns true(+1/-1)' do
        start = [3, 3]
        fin = [4, 2]
        expect(white_king.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/-1)' do
        start = [5, 5]
        fin = [5, 4]
        expect(white_king.valid_move?(start, fin)).to be true
      end

      it 'returns true(0/+1)' do
        start = [0, 0]
        fin = [0, 1]
        expect(white_king.valid_move?(start, fin)).to be true
      end
    end

    context 'movement is invalid' do
      it 'returns false if out of bounds' do
        start_x = 0
        start_y = 1
        fin_x = 9
        fin_y = 9
        expect(white_king.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false if the same' do
        start_x = 3
        start_y = 3
        fin_x = 3
        fin_y = 3
        expect(white_king.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end

      it 'returns false' do
        start_x = 3
        start_y = 3
        fin_x = 5
        fin_y = 5
        expect(white_king.valid_move?([start_x, start_y], [fin_x, fin_y])).to be false
      end
    end
  end

  describe '#pawn_checking?' do
    context 'when the spot is safe' do
      it 'returns false' do
        spot = [3, 3]
        expect(white_king.pawn_checking?(gameboard, spot)).to be false
      end
    end

    context 'when the spot is not safe' do
      it 'returns true(black-pawn)' do
        spot = [3, 3]
        gameboard.grid[2][2] = '♙'
        expect(white_king.pawn_checking?(gameboard, spot)).to be true
      end

      it 'returns true(white-pawn)' do
        spot = [3, 3]
        gameboard.grid[4][4] = '♟'
        expect(black_king.pawn_checking?(gameboard, spot)).to be true
      end
    end
  end

  describe '#rook_checking?' do
    context 'when the spot is safe' do
      it 'returns false' do
        spot = [3, 3]
        expect(white_king.rook_checking?(gameboard, spot)).to be false
      end
    end

    context 'when a piece is between the rook and king' do
      it 'returns false' do
        spot = [3, 3]
        gameboard.grid[0][3] = '♖'
        gameboard.grid[2][3] = '♜'
        expect(white_king.rook_checking?(gameboard, spot)).to be false
      end
    end

    context 'when the spot is not safe' do
      it 'returns true(black-rook)' do
        spot = [3, 3]
        gameboard.grid[0][3] = '♖'
        expect(white_king.rook_checking?(gameboard, spot)).to be true
      end

      it 'returns true(white-rook)' do
        spot = [4, 0]
        gameboard.grid[4][4] = '♜'
        expect(black_king.rook_checking?(gameboard, spot)).to be true
      end
    end
  end

  describe '#bishop_checking?' do
    context 'when the spot is safe' do
      it 'returns false' do
        spot = [3, 3]
        expect(white_king.bishop_checking?(gameboard, spot)).to be false
      end
    end

    context 'when a piece is between the bishop and king' do
      it 'returns false' do
        spot = [0, 0]
        gameboard.grid[3][3] = '♗'
        gameboard.grid[5][5] = '♝'
        expect(white_king.rook_checking?(gameboard, spot)).to be false
      end
    end

    context 'when the spot is not safe' do
      it 'returns true(black-bishop)' do
        spot = [3, 3]
        gameboard.grid[0][0] = '♗'
        expect(white_king.bishop_checking?(gameboard, spot)).to be true
      end

      it 'returns true(white-bishop)' do
        spot = [3, 3]
        gameboard.grid[1][5] = '♝'
        expect(black_king.bishop_checking?(gameboard, spot)).to be true
      end
    end
  end

  describe '#knight_checking?' do
    context 'when the spot is safe' do
      it 'returns false' do
        spot = [3, 3]
        expect(white_king.knight_checking?(gameboard, spot)).to be false
      end
    end

    context 'when the spot is not safe' do
      it 'returns true(black-knight)' do
        spot = [3, 3]
        gameboard.grid[1][2] = '♘'
        expect(white_king.knight_checking?(gameboard, spot)).to be true
      end

      it 'returns true(white-knight)' do
        spot = [3, 3]
        gameboard.grid[5][4] = '♞'
        expect(black_king.knight_checking?(gameboard, spot)).to be true
      end
    end
  end

  describe '#queen_checking?' do
    context 'when the spot is safe' do
      it 'returns false' do
        spot = [3, 3]
        expect(white_king.queen_checking?(gameboard, spot)).to be false
      end
    end

    context 'when a piece is between the bishop and king' do
      it 'returns false' do
        spot = [0, 0]
        gameboard.grid[0][5] = '♕'
        gameboard.grid[0][3] = '♛'
        expect(white_king.queen_checking?(gameboard, spot)).to be false
      end
    end

    context 'when the spot is not safe' do
      it 'returns true(black-queen)' do
        spot = [3, 3]
        gameboard.grid[0][3] = '♕'
        expect(white_king.queen_checking?(gameboard, spot)).to be true
      end

      it 'returns true(white-queen)' do
        spot = [3, 3]
        gameboard.grid[1][5] = '♛'
        expect(black_king.queen_checking?(gameboard, spot)).to be true
      end
    end
  end

  describe '#king_in_check?' do
    context 'when the spot is safe' do
      it 'returns false' do
        spot = [3, 3]
        expect(white_king.king_in_check?(gameboard, spot)).to be false
      end
    end

    context 'when a piece is between the bishop and king' do
      it 'returns false' do
        spot = [0, 0]
        gameboard.grid[0][5] = '♕'
        gameboard.grid[0][3] = '♛'
        expect(white_king.king_in_check?(gameboard, spot)).to be false
      end
    end

    context 'when the spot is not safe' do
      it 'returns true(black-knight)' do
        spot = [3, 3]
        gameboard.grid[1][2] = '♘'
        expect(white_king.king_in_check?(gameboard, spot)).to be true
      end

      it 'returns true(white-bishop)' do
        spot = [3, 3]
        gameboard.grid[1][5] = '♝'
        expect(black_king.king_in_check?(gameboard, spot)).to be true
      end
    end
  end
end
