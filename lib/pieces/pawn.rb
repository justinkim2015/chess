require_relative 'piece'

class Pawn < Piece
  attr_accessor :color

  def initialize(color)
    super()
    @color = select_color(color)
  end

  def select_color(color)
    color == 'White' ? '♟' : '♙'
  end

  # Current problem is that pawns can eat backwards and eat pieces directly
  # in front of them.
  def valid_move?(board, start, fin)
    if @color == '♙'
      return true if [fin[0], fin[1]] == [start[0] + 1, start[1]] ||
                     @white_pieces.include?(board.grid[fin[0]][fin[1]])
    else
      return true if [fin[0], fin[1]] == [start[0] - 1, start[1]] ||
                     @black_pieces.include?(board.grid[fin[0]][fin[1]])
    end
    false
  end

  def move_pawn(board, start, fin)
    return unless valid_move?(board, start, fin) && valid_spot?(board, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
  end
end
