require 'pry'

class Piece
  attr_accessor :white_pieces, :black_pieces
  
  def initialize
    @white_pieces = ['♚', '♛', '♜', '♝', '♞', '♟']
    @black_pieces = ['♔', '♕', '♖', '♗', '♘', '♙']
  end

  def update_position(fin)
    @position = fin
  end

  def move(board, start, fin)
    return unless can_attack_square?(board, start, fin)

    board.grid[fin[0]][fin[1]] = @color
    board.grid[start[0]][start[1]] = ' '
    @position = fin
  end

  def valid_move?(start, fin)
    return true if moves(start).include?(fin)

    false
  end

  def can_attack_square?(board, start = @location, fin)
    valid_move?(start, fin) && valid_spot?(board, fin)
  end

  def valid_spot?(board, spot)
    enemy_pieces = if @white_pieces.include?(@color)
                     @black_pieces
                   else
                     @white_pieces
                   end

    return true if enemy_pieces.include?(board.grid[spot[0]][spot[1]]) ||
                   board.grid[spot[0]][spot[1]] == ' '

    false
  end

  def attacking_square?(board, spot)
    all_moves = moves(spot)
    all_moves.each do |place|
      return true if board.grid[place[0]][place[1]] == @color &&
                     path_empty?(board, spot, [place[0], place[1]])
    end
    false
  end

  def attacking_square_info(board, spot)
    all_moves = moves(spot)
    all_moves.each do |place|
      if board.grid[place[0]][place[1]] == @color && path_empty?(board, spot, [place[0], place[1]])
        return { position: [place[0], place[1]],
                 piece: @color }
      end
    end
  end

  def abs_val(num)
    -num * num / num
  end
end
