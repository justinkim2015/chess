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

  # problem is it is still eating piece in front
  def valid_move?(board, start, fin)
    return false if board.grid[fin[0]].nil?

    return true if move_forward(board, start, fin) || eat_diag(board, start, fin)

    false
  end

  def move_forward(board, start, fin)
    if @color == '♙'
      return true if [fin[0], fin[1]] == [start[0] + 1, start[1]] &&
                     (start[0] + 1) <= 7 &&
                     !@white_pieces.include?(board.grid[fin[0]][fin[1]])
    else
      return true if [fin[0], fin[1]] == [start[0] - 1, start[1]] &&
                     (start[0] - 1) >= 0 &&
                     !@black_pieces.include?(board.grid[fin[0]][fin[1]])
    end
    false
  end

  def eat_diag(board, start, fin)
    if @color == '♙'
      return true if @white_pieces.include?(board.grid[fin[0]][fin[1]]) && [fin[0], fin[1]] == [start[0] + 1, start[0] - 1] ||
                     @white_pieces.include?(board.grid[fin[0]][fin[1]]) && [fin[0], fin[1]] == [start[0] + 1, start[0] + 1]
    else
      return true if @black_pieces.include?(board.grid[fin[0]][fin[1]]) && [fin[0], fin[1]] == [start[0] - 1, start[0] - 1] ||
                     @black_pieces.include?(board.grid[fin[0]][fin[1]]) && [fin[0], fin[1]] == [start[0] - 1, start[0] + 1]
    end
    false
  end

  def move_pawn(board, start, fin)
    return unless valid_move?(board, start, fin) && valid_spot?(board, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
  end
end
