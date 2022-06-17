require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'

class Game
  attr_accessor :board, :player1, :player2

  def initialize
    @player1 = Player.new('Player 1', 'White')
    @player2 = Player.new('Player 2', 'Black')
    @board = Board.new
    @turn = @player1
  end

  def move
    # Maybe refactor the piece.move method to take two arrays, start and fin
    @player1.pieces[:bishop].move(@board, 7, 2, 6, 3)
  end

  def spot_values(input)
    if input == 'a1'
      board.grid[7][0]
    elsif input == 'a2'
      board.grid[6][0]
    elsif input == 'a3'
      board.grid[5][0]
    elsif input == 'a4'
      board.grid[4][0]
    elsif input == 'a5'
      board.grid[3][0]
    elsif input == 'a6'
      board.grid[2][0]
    elsif input == 'a7'
      board.grid[1][0]
    elsif input == 'a8'
      board.grid[0][0]
    end
  end

  def place_pieces
    # board.grid[0][0] = player2.pieces[:rook].color
    # board.grid[0][1] = player2.pieces[:knight].color
    board.grid[0][2] = player2.pieces[:bishop].color
    # board.grid[0][3] = player2.pieces[:queen].color
    # board.grid[0][4] = player2.pieces[:king].color
    board.grid[0][5] = player2.pieces[:bishop].color
    # board.grid[0][6] = player2.pieces[:knight].color
    # board.grid[0][7] = player2.pieces[:rook].color
    # board.grid[1][0] = player2.pieces[:pawn].color
    # board.grid[1][1] = player2.pieces[:pawn].color
    # board.grid[1][2] = player2.pieces[:pawn].color
    # board.grid[1][3] = player2.pieces[:pawn].color
    # board.grid[1][4] = player2.pieces[:pawn].color
    # board.grid[1][5] = player2.pieces[:pawn].color
    # board.grid[1][6] = player2.pieces[:pawn].color
    # board.grid[1][7] = player2.pieces[:pawn].color

    # board.grid[7][0] = player1.pieces[:rook].color
    # board.grid[7][1] = player1.pieces[:knight].color
    board.grid[7][2] = player1.pieces[:bishop].color
    # board.grid[7][3] = player1.pieces[:queen].color
    # board.grid[7][4] = player1.pieces[:king].color
    board.grid[7][5] = player1.pieces[:bishop].color
    # board.grid[7][6] = player1.pieces[:knight].color
    # board.grid[7][7] = player1.pieces[:rook].color
    # board.grid[6][0] = player1.pieces[:pawn].color
    # board.grid[6][1] = player1.pieces[:pawn].color
    # board.grid[6][2] = player1.pieces[:pawn].color
    # board.grid[6][3] = player1.pieces[:pawn].color
    # board.grid[6][4] = player1.pieces[:pawn].color
    # board.grid[6][5] = player1.pieces[:pawn].color
    # board.grid[6][6] = player1.pieces[:pawn].color
    # board.grid[6][7] = player1.pieces[:pawn].color
  end
end