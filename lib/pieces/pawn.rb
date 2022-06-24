require_relative 'piece'

class Pawn < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @position = position
    @origin_white = [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]]
    @origin_black = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]
  end

  def select_color(color)
    color == 'White' ? '♟' : '♙'
  end

  def valid_move?(board, start, fin)
    return false if board.grid[fin[0]].nil?

    return true if move_forward(board, start, fin) ||
                   eat_diag(board, start, fin) ||
                   move_two(board, start, fin)

    false
  end

  def move_two(board, start, fin)
    if @color == '♙' && @origin_black.include?(start)
      return true if [fin[0], fin[1]] == [start[0] + 2, start[1]] &&
                     !@white_pieces.include?(board.grid[fin[0]][fin[1]])
    elsif @color == '♟' && @origin_white.include?(start)
      return true if [fin[0], fin[1]] == [start[0] - 2, start[1]] &&
                     !@black_pieces.include?(board.grid[fin[0]][fin[1]])
    end
    false
  end

  def move_forward(board, start, fin)
    if @color == '♙'
      return true if moves(start).include?(fin) &&
                     !@white_pieces.include?(board.grid[fin[0]][fin[1]])
    else
      return true if moves(start).include?(fin) &&
                     !@black_pieces.include?(board.grid[fin[0]][fin[1]])
    end
    false
  end

  def eat_diag(board, start, fin)
    if @color == '♙'
      return true if @white_pieces.include?(board.grid[fin[0]][fin[1]]) &&
                     [fin[0], fin[1]] == [start[0] + 1, start[1] - 1] ||

                     @white_pieces.include?(board.grid[fin[0]][fin[1]]) &&
                     [fin[0], fin[1]] == [start[0] + 1, start[1] + 1]
    else
      return true if @black_pieces.include?(board.grid[fin[0]][fin[1]]) &&
                     [fin[0], fin[1]] == [start[0] - 1, start[1] - 1] ||

                     @black_pieces.include?(board.grid[fin[0]][fin[1]]) &&
                     [fin[0], fin[1]] == [start[0] - 1, start[1] + 1]
    end
    false
  end

  def move_pawn(board, start, fin)
    return unless valid_move?(board, start, fin) && valid_spot?(board, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
  end

  def moves(location, result = [])
    move = @color == '♙' ? [1, 0] : [-1, 0]
    x = location[0] + move[0]
    y = location[1] + move[1]
    result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    result
  end
end
