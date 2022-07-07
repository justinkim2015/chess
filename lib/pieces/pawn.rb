require_relative 'piece'

class Pawn < Piece
  attr_accessor :color, :position

  def initialize(color, position)
    super()
    @color = select_color(color)
    @original_position = position
    @position = position
  end

  def select_color(color)
    color == 'White' ? '♟' : '♙'
  end

  # NOT FINISHED, only works for white
  def pawn_upgrade?(spot)
    final_row = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
    return true if final_row.include?(spot)

    false
  end

  def valid_move?(board, start, fin)
    return false if board.grid[fin[0]].nil?

    return true if move_forward(board, start, fin) ||
                   eat_diag(board, start, fin)

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
                     diag_moves(start).include?(fin)
    else
      return true if @black_pieces.include?(board.grid[fin[0]][fin[1]]) &&
                     diag_moves(start).include?(fin)
    end
    false
  end

  # This has to be different from Piece class because valid_move? needs to have
  # the board argument passed to it.
  def move_pawn(board, start, fin)
    return unless valid_move?(board, start, fin) && valid_spot?(board, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
    @location = fin
  end

  def diag_moves(location, result = [])
    moves = @color == '♙' ? [[1, -1], [1, 1]] : [[-1, -1], [-1, 1]]

    moves.each do |move|
      x = location[0] + move[0]
      y = location[1] + move[1]
      result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end

    result
  end

  def moves(location, result = [])
    moves = @color == '♙' ? [[1, 0]] : [[-1, 0]]

    moves << if @original_position == @position && color == '♙'
               [2, 0]
             else
               [-2, 0]
             end

    moves.each do |move|
      x = location[0] + move[0]
      y = location[1] + move[1]
      result << [x, y] if x.between?(0, 7) && y.between?(0, 7)
    end

    result
  end

  # Maybe change name to attacked_by_pawn?
  def pawn_attacking_square?(board, spot)
    all_moves = diag_moves(spot)
    all_moves.each do |move|
      return true if board.grid[move[0]][move[1]] == @color
    end
    false
  end

  def pawn_attacking_square_info(board, spot)
    all_moves = moves(spot)
    all_moves.each do |move|
      if board.grid[move[0]][move[1]] == @color && path_empty?(board, spot, [move[0], move[1]])
        return { location: [move[0], move[1]],
                 piece: @color }
      end
    end
  end
end
