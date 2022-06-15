require_relative './pieces/king'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'

class Game
  def initialize
    @player1 = Player.new('Player 1', 'White')
    @player2 = Player.new('Player 2', 'Black')
    @board = Board.new
    @turn = @player1
    @white_pieces = white_pieces
    @black_pieces = black_pieces
  end

  def create_pieces
  end

  def set_board
    @board.grid[0][0] = Knight.new.black_piece
  end
end